# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/pcgen/pcgen-5.14.0.ebuild,v 1.1 2008/08/02 00:51:44 mr_bones_ Exp $

inherit versionator games

MY_PV=$(delete_all_version_separators)
DESCRIPTION="D&D character generator"
HOMEPAGE="http://pcgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcgen/pcgen${MY_PV}_full.zip"

LICENSE="LGPL-2 OGL-1.0a"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND="app-arch/unzip"

S=${WORKDIR}/pcgen${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f *.bat
	sed -i "/dirname/ c\cd \"${GAMES_DATADIR}\/${PN}\"" pcgen.sh \
		|| die "sed pcgen.sh failed"
	mv -f pcgen.sh "${T}"/${PN}
}

src_install() {
	dogamesbin "${T}"/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r * || die "doins failed"
	keepdir "${GAMES_DATADIR}"/${PN}/characters
	prepgamesdirs
}
