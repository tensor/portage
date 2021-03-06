# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ocrad/ocrad-0.17.ebuild,v 1.4 2008/05/24 16:31:50 nixnut Exp $

inherit eutils toolchain-funcs

DESCRIPTION="GNU Ocrad is an OCR (Optical Character Recognition) program"
HOMEPAGE="http://www.gnu.org/software/ocrad/ocrad.html"
SRC_URI="http://savannah.nongnu.org/download/ocrad/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	doman doc/ocrad.1
	doinfo doc/ocrad.info
	dodoc AUTHORS NEWS README TODO
	insinto /usr/share/doc/${PF}
	doins -r examples
}
