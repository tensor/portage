# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/digger/digger-20020314.ebuild,v 1.11 2007/04/09 21:58:46 welp Exp $

inherit eutils games

DESCRIPTION="Digger Remastered"
HOMEPAGE="http://www.digger.org/"
SRC_URI="http://www.digger.org/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc3.patch
}

src_compile() {
	emake -f Makefile.sdl || die
}

src_install() {
	dogamesbin digger || die "dogamesbin failed"
	dodoc digger.txt
	make_desktop_entry digger Digger
	prepgamesdirs
}
