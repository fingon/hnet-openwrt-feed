#!/bin/sh

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

proto_hnet_init_config() {
    # XXX - do we want per-interface knobs?
    local dummy
}

proto_hnet_setup() {
    local config="$1"
    local iface="$2"

    # It won't be 'up' before we provide first config.

    # So we provide _empty_ config here, and let pm.lua deal with
    # configuring real parameters there later..
    proto_init_update "*" 1
    proto_send_update "$iface"
}

proto_hnet_teardown() {
    local interface="$1"
    # nop?
    proto_init_update "*" 0
    proto_send_update "$interface"
}

add_protocol hnet

