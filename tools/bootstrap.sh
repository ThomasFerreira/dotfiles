#!/bin/sh -

### Bootstrap my base install using ansible...
### We really need to have python (v >= 3.6) and git installed.

REPOSITORY_LOCATION="https://github.com/ThomasFerreira/dotfiles.git"
PIP_ANSIBLE_REQUIREMENT="ansible==2.5.*"

CURRENT_HOST="$(hostname | sed -e 's/\(.*\)/\L\1/')"

TARGET_BRANCH="${TARGET_BRANCH:-master}"

###

command -v python3 >/dev/null 2>&1 \
    || { echo "Dammit! python3 is not installed." >&2; exit 1; }
python3 -c 'import sys; sys.exit(1 if (sys.hexversion <= 0x03060000) else 0)' \
    || { echo "Dammit! update python3 to at least v3.6." >&2; exit 1; }

TEMP_DIRECTORY_PATH="$(python3 -c 'import tempfile; print(tempfile.mkdtemp())')"
chmod 755 "${TEMP_DIRECTORY_PATH}"
trap '{ rm -rf -- "${TEMP_DIRECTORY_PATH}"; }' EXIT

OLD_PWD="${PWD}"
cd "${TEMP_DIRECTORY_PATH}" || exit 42
export HOME="${TEMP_DIRECTORY_PATH}"

echo "Building python virtualenv..."
python3 -m venv python_venv
. ./python_venv/bin/activate

pip install --upgrade "pip"
pip install "${PIP_ANSIBLE_REQUIREMENT}"

git clone -b "${TARGET_BRANCH}" "${REPOSITORY_LOCATION}" \
    "${TEMP_DIRECTORY_PATH}/repository"

if [ -r "${TEMP_DIRECTORY_PATH}/repository/bootstrap.cfg" ]; then
    ANSIBLE_CONFIG="${TEMP_DIRECTORY_PATH}/repository/bootstrap.cfg"
elif [ -r "${TEMP_DIRECTORY_PATH}/repository/ansible.cfg" ]; then
    ANSIBLE_CONFIG="${TEMP_DIRECTORY_PATH}/repository/ansible.cfg"
fi
[ -n "${ANSIBLE_CONFIG}" ] && export ANSIBLE_CONFIG

ANSIBLE_ROOT="$(dirname "${ANSIBLE_CONFIG}")"
export ANSIBLE_ROOT

ansible-playbook --vault-id @prompt -i "${ANSIBLE_ROOT}/inventory/${CURRENT_HOST}" "${ANSIBLE_ROOT}/main.yml"
deactivate

cd "${OLD_PWD}" || exit 42
