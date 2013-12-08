#!/bin/sh

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

proto_hnet_init_config() {
    # XXX - do we want per-interface knobs?
    local dummy
}

proto_hnet_setup() {
    local interface="$1"
    local device="$2"

    # Start fake daemon if need be (not needed it seems)
    #proto_run_command "$interface" sleep 9999999

    # It won't be 'up' before we provide first config.
    # So we provide _empty_ config here, and let pm.lua deal with
    # configuring real parameters there later..
    proto_init_update "*" 1
    proto_send_update "$interface"

    # add sub-protocols for DHCPv4 + DHCPv6
    json_init
    json_add_string name "${interface}_4"
    json_add_string ifname "@${interface}"

    # vendor specific option (125)
    # 4b - Steven Barth's enterprise number (30462)
    # data-len1 (2)
    # subopt-code (1)
    # subopt-len (0)
    json_add_string sendopts "0x7d:000076fe020100"

    json_add_string proto dhcp
    json_close_object
    ubus call network add_dynamic "$(json_dump)"

    json_init
    json_add_string name "${interface}_6"
    json_add_string ifname "@${interface}"
    json_add_string proto dhcpv6

    # Require PD, not only NA/SLAAC
    json_add_string forceprefix 1

    # Disable automatic netifd-level prefix delegation for this interface
    json_add_boolean delegate 0

    json_close_object
    ubus call network add_dynamic "$(json_dump)"

    # Prod hnetd
    until hnet-call "{\"command\": 0, \"ifname\": \"$device\", \"handle\": \"$interface\"}" ; do sleep 1 ; done
}

proto_hnet_teardown() {
    local interface="$1"
    local device="$2"
    # nop? this? hmm
    proto_init_update "*" 0
    proto_send_update "$interface"

    #proto_kill_command "$interface"
    # Prod hnetd
    until hnet-call "{\"command\": 1, \"ifname\": \"$device\", \"handle\": \"$interface\"}" ; do sleep 1 ; done
}

add_protocol hnet

