# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ipadic/ipadic-2.6.1.ebuild,v 1.10 2006/04/28 13:54:45 hattya Exp $

IUSE=""

DESCRIPTION="Japanese dictionary for ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/chasen/distribution.html.en"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/ipadic/${P}.tar.gz"

LICENSE="ipadic"
KEYWORDS="x86 amd64 ppc"
SLOT="0"

DEPEND=">=app-text/chasen-2.3.2"

src_compile() {
	sed -i -e "/^install-data-am:/s/install-data-local//" Makefile.in
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	insinto /etc
	doins chasenrc
	dodoc README NEWS || die
}
