# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/maitretarot/maitretarot-0.1.98.ebuild,v 1.5 2008/03/14 00:52:52 wolf31o2 Exp $

inherit games

DESCRIPTION="server for the french tarot game maitretarot"
HOMEPAGE="http://www.nongnu.org/maitretarot/"
SRC_URI="http://savannah.nongnu.org/download/maitretarot/${PN}.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=dev-libs/glib-2*
	dev-libs/libxml2
	dev-games/libmaitretarot"

src_compile() {
	egamesconf \
		--with-default-config-file="${GAMES_SYSCONFDIR}/maitretarotrc.xml" \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	prepgamesdirs
}
