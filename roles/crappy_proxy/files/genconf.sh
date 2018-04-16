#!/usr/bin/sh -

BASEDIR="$(dirname "$0")"
BASECONFDIR="$(dirname "${BASEDIR}")/conf"

TARGETCONF="${1:-/run/crappy_proxy/tinyproxy.conf}"
TARGETCONFDIR="$(dirname "${TARGETCONF}")"

die() { echo "Error: $1" >&2; exit 42; }

mkdir -p "${TARGETCONFDIR}" \
    || die "Cannot create ${TARGETCONFDIR}."
chown tinyproxy:tinyproxy "${TARGETCONFDIR}" \
    || die "Cannot change owner of ${TARGETCONFDIR}."
cat "${BASECONFDIR}/base.conf" > "${TARGETCONF}" \
    || die "Cannot append configuration fragment to ${TARGETCONF}"

for _NET_CONF in ${BASEDIR}/genconf.sh.d/*.conf.sh; do
    if [ -r "${_NET_CONF}" ]; then
	# shellcheck disable=SC2024 #
	CONF_TO_APPEND="$(sudo -u tinyproxy sh - < "${_NET_CONF}")" \
	    && echo "${CONF_TO_APPEND}" >> "${TARGETCONF}"
    fi
done

exit 0
