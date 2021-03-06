# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/aaindex/aaindex-9.1.ebuild,v 1.6 2006/11/20 20:57:06 blubb Exp $

DESCRIPTION="Amino acid indices and similarity matrices"
LICENSE="public-domain"
HOMEPAGE="http://www.genome.ad.jp/aaindex"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
# Minimal build keeps only the indexed files (if applicable) and the
# documentation. The non-indexed database is not installed.
IUSE="emboss minimal"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"

DEPEND="emboss? ( sci-biology/emboss )"

src_compile() {
	if use emboss; then
		mkdir AAINDEX
		echo
		einfo "Indexing AAindex for usage with EMBOSS."
		EMBOSS_DATA="." aaindexextract -auto -infile ${PN}1 || die \
			"Indexing AAindex failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins ${PN}{1,2,3} || die "Failed to install raw database."
	fi
	dodoc ${PN}.doc || die "Failed to install documentation."
	if use emboss; then
		insinto /usr/share/EMBOSS/data/AAINDEX
		doins AAINDEX/* || die "Failed to install EMBOSS data files."
	fi
}
