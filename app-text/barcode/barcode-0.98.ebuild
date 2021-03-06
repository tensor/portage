# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/barcode/barcode-0.98.ebuild,v 1.17 2009/02/27 21:43:50 tove Exp $

inherit eutils toolchain-funcs

DESCRIPTION="barcode generator"
HOMEPAGE="http://www.gnu.org/software/barcode/"
SRC_URI="mirror://gnu/barcode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~arm"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-info.patch
	sed -i \
		-e 's:/info:/share/info:' \
		-e 's:/man/:/share/man/:' \
		Makefile.in || die "sed failed"
}

src_compile() {
	tc-export CC
	econf
	emake || die "emake failed"
}

src_install() {
	emake install prefix="${D}/usr" LIBDIR="\$(prefix)/$(get_libdir)" || die
	dodoc ChangeLog README TODO doc/barcode.{pdf,ps}
}
