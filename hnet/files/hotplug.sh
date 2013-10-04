#!/bin/sh
# Update that something changed in netifd -> pm.lua'll
# refresh the ubus call network.interface/dump -> things happen
skvtool "network-interface-updated=$$"
