# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/openmoko-dfu-util/openmoko-dfu-util-9999.ebuild,v 1.3 2009/06/20 21:57:27 mrness Exp $

EAPI="2"

ESVN_REPO_URI="http://svn.openmoko.org/trunk/src/host/dfu-util/"
inherit subversion autotools

DESCRIPTION="implements the Host (PC) side of the USB DFU (Device Firmware Upgrade) protocol"
HOMEPAGE="http://wiki.openmoko.org/wiki/Dfu-util"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libusb:0"
RDEPEND="${DEPEND}"

src_prepare() {
	subversion_src_prepare
	sed -i '/^bin_PROGRAMS/s:dfu-util_static::' src/Makefile.am
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"
	doman doc/dfu-util.1
}
