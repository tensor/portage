# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-2.0.9.1.ebuild,v 1.2 2009/01/22 10:20:48 tupone Exp $

inherit eutils versionator games

MY_P=${PN}2-$(get_after_major_version)
DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://clanbomber.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/DirectFB-1
	media-libs/FusionSound"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon ${PN}/pics/cup2.png ${PN}.png
	make_desktop_entry clanbomber2 ClanBomber2
	dodoc AUTHORS ChangeLog IDEAS README
	prepgamesdirs
}
