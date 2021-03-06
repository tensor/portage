# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fbzx/fbzx-1.10.ebuild,v 1.3 2008/07/15 14:32:01 armin76 Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="A Sinclair Spectrum emulator, designed to work at full screen using the FrameBuffer"
HOMEPAGE="http://www.rastersoft.com/fbzx.html"
SRC_URI="http://www.rastersoft.com/descargas/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|/usr/share/spectrum|${GAMES_DATADIR}/${PN}|g" \
		emulator.c || die "sed failed"
	sed -i \
		-e "/^CC/s:gcc:$(tc-getCC):" \
		-e "s/^\(CC =\).*/\1 $(tc-getCC) ${CFLAGS}/" \
		-e "s:-O2:${CFLAGS}:" \
		Makefile || die "sed failed"
}

src_compile() {
	rm -f fbzx_fs fbzx *.o # clean out accidentally packaged .o files
	emake || die
}

src_install() {
	dogamesbin fbzx || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}/roms"
	doins roms/* || die "doins failed"
	dodoc CAPABILITIES FAQ PORTS README* TODO VERSIONS
	prepgamesdirs
}
