# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/raine/raine-0.51.5.ebuild,v 1.1 2009/07/29 04:05:16 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="R A I N E  M680x0 Arcade Emulation"
HOMEPAGE="http://rainemu.swishparty.co.uk/"
SRC_URI="http://rainemu.swishparty.co.uk/html/archive/raines-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE="static"

RDEPEND="dev-cpp/muParser
	media-libs/libsdl
	sys-libs/zlib
	media-libs/sdl-image[png]
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-lang/nasm
	app-arch/unzip"

src_prepare() {
	echo > detect-cpu
	echo > cpuinfo
	sed -i \
		-e "/^NEO/s:^:#:" \
		-e "s:nasmw:nasm:" \
		-e "/bindir/s:=.*:=\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/sharedir =/s:=.*:=\$(DESTDIR)${GAMES_DATADIR}:" \
		-e "/mandir/s:=.*:=\$(DESTDIR)/usr/share/man/man6:" \
		makefile \
		|| die "sed failed"
}

src_compile() {
	local myopts

	use static \
		&& myopts="${myopts} STATIC=1" \
		|| myopts="${myopts} STATIC="
	emake \
		_MARCH="${CFLAGS}" \
		${myopts} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/{roms,artwork,emudx,scripts/raine}
	dodoc docs/readme.txt
	prepgamesdirs
}
