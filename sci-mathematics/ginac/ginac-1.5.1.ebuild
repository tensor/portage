# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ginac/ginac-1.5.1.ebuild,v 1.3 2009/05/30 09:14:11 ulm Exp $

EAPI=2
inherit eutils

DESCRIPTION="C++ library and tools for symbolic calculations"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/GiNaC/${P}.tar.bz2"
HOMEPAGE="http://www.ginac.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=sci-libs/cln-1.2.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen
		   media-gfx/transfig
		   || ( dev-texlive/texlive-fontsrecommended
				app-text/ptex ) )"

src_prepare() {
	# 2 harmless patches from fedora
	epatch "${FILESDIR}"/${P}-lexer_cpp.patch
	epatch "${FILESDIR}"/${P}-pkgconfig.patch
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${S}/doc/reference"
		#pdf generation for reference failed (1.5.1), bug #264774
		#emake html pdf || die "emake doc reference failed"
		emake html || die "emake ref failed"
		cd "${S}/doc/tutorial"
		emake ginac.pdf ginac.html || die "emake doc tutorial failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS AUTHORS || die

	if use doc; then
		cd doc
		insinto /usr/share/doc/${PF}
		newins tutorial/ginac.pdf tutorial.pdf || die "tutorial install failed"
		#newins reference/ginac.pdf reference.pdf || die "ref install failed"
		insinto /usr/share/doc/${PF}/html/reference
		doins -r reference/html_files/* || die
		insinto /usr/share/doc/${PF}/html
		newins tutorial/ginac.html tutorial.html
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cpp examples/ginac-examples.txt
	fi
}
