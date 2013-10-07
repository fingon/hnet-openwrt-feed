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
    json_add_string proto dhcp
    json_close_object
    ubus call network add_dynamic "$(json_dump)"

    json_init
    json_add_string name "${interface}_6"
    json_add_string ifname "@${interface}"
    json_add_string proto dhcpv6
    #XXX - these should work, but they don't - wait for sbyx's patch
    #json_add_string noslaaconly 1
    #json_add_string reqaddress none
    json_add_string forceprefix 1
    json_close_object
    ubus call network add_dynamic "$(json_dump)"
}

proto_hnet_teardown() {
    local interface="$1"
    # nop? this? hmm
    proto_init_update "*" 0
    proto_send_update "$interface"

    #proto_kill_command "$interface"
}

add_protocol hnet

