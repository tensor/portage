# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chasen/chasen-2.4.4.ebuild,v 1.1 2008/07/31 16:07:27 matsuu Exp $

inherit perl-module

DESCRIPTION="Japanese Morphological Analysis System, ChaSen"
HOMEPAGE="http://chasen-legacy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp//chasen-legacy/32224/${P}.tar.gz"

LICENSE="chasen"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="perl"

DEPEND=">=dev-libs/darts-0.32"
RDEPEND="${DEPEND}
	perl? ( !dev-perl/Text-ChaSen )"
PDEPEND=">=app-dicts/ipadic-2.7.0"

src_compile() {
	econf || die
	emake || die
	if use perl ; then
		cd "${S}"/perl
		perl-module_src_compile
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README

	if use perl ; then
		cd "${S}"/perl
		perl-module_src_install
		newdoc README README.perl
	fi
}
