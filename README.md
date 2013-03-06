    Created:       Wed Nov  7 14:15:39 2012 mstenber
    Last modified: Wed Mar  6 15:16:40 2013 mstenber

hnet-openwrt-feed
=================

(c) cisco Systems, Inc., 2012

License: See COPYING - GPLv2.

This is OpenWrt convenience feed for [hnet-core][core] and all it's
dependencies.

# Caveats

BIRD's OSPF(v3) doesn't work very well on bridged links. Please make sure
that the OpenWRT box you have is configured without bridging whatsoever, to
make sure. If bridged link is encountered, OSPF neighbor relationships will
NOT be established, and your hnet setup will simply fail to work.

# Simple usage

We make the assumption that the reader is moderately familiar with
[OpenWRT build process][root]. If not, it might be good time to brush up..

Get the source tree of AA:

    git clone git://nbd.name/attitude_adjustment.git

Add following line to feeds.conf:

    src-git hnet git://github.com/fingon/hnet-openwrt-feed.git

Update feeds + install hnet by running:

    scripts/feeds update
    scripts/feeds install hnet

.. and then 

    make menuconfig

Some changes from defaults are needed. One option is to use the
ietf86-config file provided within the repository (copy ietf86-config to
.config), or the changes can be also made by hand: convert the base libc
from uClibc to eglibc (advanced configuration options -> toolchain options
-> C library implementation). Then, you want to choose 'y' for hnet package
(IPv6 -> hnet). ('m' not tested very much, but 'y' at least seems to
work.). Finally, appropriate target should be chosen (ietf86-config
defaults to Buffalo WZR-HP-AG300H / WZR-600DHR). 

Then, make new image, flash it, and configure to your's heart's content.

NOTE: By default, the current version has several limitations:

* firewall is disabled (as we don't have good integration with 
  OpenWRT zones yet)
  
* you cannot choose (using some elegant way, at any rate) the active interfaces

.. and therefore the hnet package is disabled even if built into the
image. To test just once (without changing permanent configuration):

    /etc/init.d/hnet start

To enable it every boot:

    /etc/init.d/hnet enable

# If you see something odd..

First, please look at [TODO][TODO]. Whatever you find, it might be a known
misfeature. If not, feel free to fix it yourself, start an issue here, or
e-mail me about it. 

[core]: https://github.com/fingon/hnet-core/
[TODO]: https://github.com/fingon/hnet-core/blob/master/TODO
[root]: http://wiki.openwrt.org/doc/howto/build
