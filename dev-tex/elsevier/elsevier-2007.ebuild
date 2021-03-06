# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

DESCRIPTION="LaTeX classes and BibTeX styles for Elsevier Science journals."
SRC_URI="http://dev.gentooexperimental.org/~dreeevil/${P}.zip
		http://dev.gentooexperimental.org/~dreeevil/${PN}-bib-${PV}.zip"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/elsevier.html"
LICENSE="LPPL-1.3c"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/latex-base"
DEPEND="${RDEPEND}
	app-arch/unzip"

SUPPLIER="public"

S=${WORKDIR}/${PN}

src_install() {
	latex-package_src_doinstall cls bst
	dodoc *.pdf *.tex README README-bst || die "dodoc failed"
}
