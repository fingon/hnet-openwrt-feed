#!/bin/sh

. /lib/functions/uci-defaults.sh
. /lib/ar71xx.sh

ucidef_set_interface_hnet() {
	local cfg=$1
	local ifname=$2
	uci batch <<EOF
set network.$cfg='interface'
set network.$cfg.ifname='$ifname'
set network.$cfg.proto='hnet'
EOF
}

board=$(ar71xx_board_name)

# Check whether an hnet config file is available
case "$board" in
wndr3700 |\
wzr-hp-ag300h) 
	;;
*)
	echo " ! No available hnet network config. for this platform !"
	exit 0
	;;
esac

# Backing up
if [ -e /etc/config/network ]
then
	echo " * Backing-up previous network config. file."
	mv /etc/config/network /etc/config/network.hnetbak
fi

echo " * Installing hnet network config. file"

# Creating config
touch /etc/config/network

uci delete network.globals
ucidef_set_interface_loopback

# Switch config
case "$board" in
wndr3700)
	ucidef_add_switch "rtl8366s" "1" "1"
	uci set network.@switch[-1].enable_vlan4k='1'
	ucidef_add_switch_vlan "rtl8366s" "1" "3 5t"
	ucidef_add_switch_vlan "rtl8366s" "2" "2 5t"
	ucidef_add_switch_vlan "rtl8366s" "3" "1 5t"
	ucidef_add_switch_vlan "rtl8366s" "4" "0 5t"
	;;
wzr-hp-ag300h)
	ucidef_add_switch "switch0" "1" "1"
	ucidef_add_switch_vlan "switch0" "1" "0t 4"
	ucidef_add_switch_vlan "switch0" "2" "0t 3"
	ucidef_add_switch_vlan "switch0" "3" "0t 2"
	ucidef_add_switch_vlan "switch0" "4" "0t 1"
	;;
esac

#Interfaces config
case "$board" in
wndr3700 |\
wzr-hp-ag300h)
	ucidef_set_interface_hnet "h01" "eth0.1"
	ucidef_set_interface_hnet "h02" "eth0.2"
	ucidef_set_interface_hnet "h03" "eth0.3"
	ucidef_set_interface_hnet "h04" "eth0.4"
	ucidef_set_interface_hnet "h1" "eth1"
	;;
esac

uci commit network

exit 0
