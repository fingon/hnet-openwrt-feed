    Created:       Wed Nov  7 14:15:39 2012 mstenber
    Last modified: Thu Nov 22 16:17:10 2012 mstenber

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

.. and then either 

    make oldconfig

.. or ..

    make menuconfig

At any rate, you want to say 'y' or 'm' to hnet package. ('m' not tested
very much, but 'y' at least seems to work.)

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
