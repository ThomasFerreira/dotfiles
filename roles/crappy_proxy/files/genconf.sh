#!/usr/bin/sh

BASEDIR=$(dirname "$0")
CONFDIR="${BASEDIR}/../conf"

TARGETCONF="${1:-/run/crappy_proxy/tinyproxy.conf}"

mkdir -p "$(dirname "${TARGETCONF}")"
chown tinyproxy:tinyproxy "$(dirname "${TARGETCONF}")"

echo "" > "${TARGETCONF}"

cat "${CONFDIR}/base.conf" > "${TARGETCONF}"

for _NET_CONF in ${BASEDIR}/genconf.sh.d/*.conf.sh; do
    if [ -x "${_NET_CONF}" ]; then
	${_NET_CONF} >> "${TARGETCONF}"
    fi
done
