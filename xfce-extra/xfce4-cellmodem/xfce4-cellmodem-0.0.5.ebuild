# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cellmodem/xfce4-cellmodem-0.0.5.ebuild,v 1.9 2009/08/01 01:48:23 darkside Exp $

# This is the wrong approach, but there is no motivation to fix tests here. bug
# 277146
RESTRICT="test"

inherit autotools eutils xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Panel plugin for monitoring cellular modems - GPRS/UMTS(3G)/HSDPA(3.5G)"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="sys-apps/pciutils
	=virtual/libusb-0*"
DEPEND="${RDEPEND}
	>=dev-util/xfce4-dev-tools-${XFCE_MASTER_VERSION}
	dev-util/pkgconfig
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	intltoolize --force --copy --automake || die "intltoolize failed."
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
