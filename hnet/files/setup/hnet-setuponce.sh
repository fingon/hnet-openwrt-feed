#!/bin/sh

HNET_SETUP=/usr/share/hnet/setup
HNET_CONFIG=/usr/share/hnet/config

if [ -f ${HNET_SETUP}/disdnsmasq ]
then
	/bin/echo " * Disabling dnsmasq"
	/etc/init.d/dnsmasq stop
	/etc/init.d/dnsmasq disable
fi

if [ -f ${HNET_SETUP}/network -a -f ${HNET_CONFIG}/network ]
then
	/bin/echo " * Replacing network configuration"
	if [ -f /etc/config/network ]
	then
		/bin/echo "   * Backing-up previous network config. file"
		/bin/mv /etc/config/network /etc/config/network.bak
	fi
	/bin/cp ${HNET_CONFIG}/network /etc/config/network
fi

if [ -f ${HNET_SETUP}/hostname ]
then
	HOSTNAME=`cat ${HNET_SETUP}/hostname`
	/bin/echo " * Setting hostname to '$HOSTNAME'"
	/sbin/uci set "system.@system[0].hostname=$HOSTNAME"
	/sbin/uci commit system
fi

/bin/rm -rf $HNET_SETUP

exit 0
