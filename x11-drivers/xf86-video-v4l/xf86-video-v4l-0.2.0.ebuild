# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-v4l/xf86-video-v4l-0.2.0.ebuild,v 1.7 2009/06/23 19:58:53 klausman Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="video4linux driver"
KEYWORDS="alpha amd64 arm ia64 ~mips ~ppc ~ppc64 sh sparc x86"
IUSE=""
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xproto"
