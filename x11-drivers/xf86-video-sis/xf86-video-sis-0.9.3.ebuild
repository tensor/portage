# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-sis/xf86-video-sis-0.9.3.ebuild,v 1.9 2009/05/04 16:32:44 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="SiS and XGI video driver"
KEYWORDS="amd64 ia64 ppc x86 ~x86-fbsd"
IUSE="dri"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86miscproto
	x11-proto/xineramaproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
			>=x11-libs/libdrm-2 )"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
