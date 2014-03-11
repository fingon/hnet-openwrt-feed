#!/bin/sh

uci batch <<EOF
	add firewall rule
	set firewall.@rule[-1].name='Allow-IPv6-Multicast'
	set firewall.@rule[-1].src='wan'
	set firewall.@rule[-1].dest_ip='ff00::/8'
	set firewall.@rule[-1].family='ipv6'
	set firewall.@rule[-1].proto='udp'
	set firewall.@rule[-1].target='ACCEPT'
EOF

uci batch <<EOF
	add firewall rule
	set firewall.@rule[-1].name='Allow-PIM'
	set firewall.@rule[-1].src='wan'
	set firewall.@rule[-1].src_ip='fe80::/10'
	set firewall.@rule[-1].family='ipv6'
	set firewall.@rule[-1].proto='103'
	set firewall.@rule[-1].target='ACCEPT'
EOF

uci commit firewall

exit 0

