# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mbuffer/mbuffer-20070911.ebuild,v 1.4 2007/12/04 17:45:52 nixnut Exp $

inherit eutils autotools

DESCRIPTION="M(easuring)buffer is a replacement for buffer with additional functionality"
HOMEPAGE="http://www.maier-komor.de/mbuffer.html"
SRC_URI="http://www.maier-komor.de/software/mbuffer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug ssl"

RDEPEND="ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-20070317-configure.patch
	epatch "${FILESDIR}"/${PN}-20070317-mandir.patch
	sed -i 's: -O : :' Makefile.in
}

src_compile() {
	econf \
		$(use_enable ssl md5) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "compile problem"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
