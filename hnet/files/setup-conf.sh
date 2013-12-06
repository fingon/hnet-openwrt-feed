#!/bin/sh

HNET_DIR=/usr/share/hnet

# No setup file means no particular operations to do
[ ! -e ${HNET_DIR}/setupconf ] && exit 0

. ${HNET_DIR}/setupconf

if [ -n "${HNET_SETUP_DISDNSMASQ}" ]
then
	/bin/echo " * Disabling dnsmasq"
	/etc/init.d/dnsmasq stop
	/etc/init.d/dnsmasq disable
fi

if [ -n "${HNET_SETUP_HOSTNAME}" ]
then
	/bin/echo " * Setting hostname to '${HNET_SETUP_HOSTNAME}'"
	/sbin/uci set "system.@system[0].hostname=${HNET_SETUP_HOSTNAME}"
	/sbin/uci commit system
fi

rm -f ${HNET_DIR}/setupconf

