# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/kwappen/kwappen-1.1.5.ebuild,v 1.4 2008/08/13 05:54:21 mr_bones_ Exp $

inherit eutils kde
need-kde 3

DESCRIPTION="A jigsaw puzzle game for the KDE environment"
HOMEPAGE="http://www.lcs-chemie.de/kwappen_eng.htm"
SRC_URI="http://www.lcs-chemie.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_unpack()
{
	kde_src_unpack
	cd "${S}"
	# Sorry if you speak portuguese... (bug #206370)
	# Better patch for this welcome.
	epatch "${FILESDIR}/${P}-br.patch"
}
