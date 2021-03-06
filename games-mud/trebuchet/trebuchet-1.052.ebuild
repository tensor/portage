# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/trebuchet/trebuchet-1.052.ebuild,v 1.6 2008/03/07 01:25:47 wolf31o2 Exp $

inherit games

MY_P="TrebTk${PV/./}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A crossplatform TCL/TK based MUD client"
HOMEPAGE="http://belfry.com/fuzzball/trebuchet/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=dev-lang/tk-8.3.3
	dev-lang/tcl"

src_unpack() {
	unpack ${A}

	sed -i \
		-e "/Nothing/d" \
		-e "/LN/ s:../libexec:${GAMES_DATADIR}:" "${S}"/Makefile \
			|| die "sed Makefile failed"
}

src_install() {
	make prefix="${D}${GAMES_PREFIX}" \
		ROOT="${D}${GAMES_DATADIR}/${PN}" \
			install || die "make install failed"
	# gui uses the COPYING file
	cp COPYING "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc changes.txt ideas.txt proxysam.txt readme.txt trebtodo.txt
	prepgamesdirs
}
