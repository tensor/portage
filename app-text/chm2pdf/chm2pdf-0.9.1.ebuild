# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chm2pdf/chm2pdf-0.9.1.ebuild,v 1.3 2009/07/15 13:26:55 fauli Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A script that converts a CHM file into a single PDF file."
HOMEPAGE="http://code.google.com/p/chm2pdf/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/pychm
	app-text/htmldoc
	dev-libs/chmlib
	dev-lang/python"

src_prepare(){
	epatch "${FILESDIR}/tempdir.patch"
}

src_install() {
	dobin ${PN} || die "failed to create executable"
	dodoc README || die "dodoc failed"
}
