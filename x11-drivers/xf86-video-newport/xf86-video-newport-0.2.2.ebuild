# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-newport/xf86-video-newport-0.2.2.ebuild,v 1.1 2009/07/11 09:21:00 remi Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="Newport video driver"
KEYWORDS="-* ~mips"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xproto"
