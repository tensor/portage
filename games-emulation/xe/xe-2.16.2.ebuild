# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/xe/xe-2.16.2.ebuild,v 1.1 2009/07/14 06:29:20 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="a multi system emulator for many console and handheld video game systems"
HOMEPAGE="http://www.xe-emulator.com/"
SRC_URI="http://www.xe-emulator.com/files/${PN}-x86-32-bin.${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="x11-libs/libXv
	x11-libs/libXinerama
	x11-libs/libXxf86vm
	sys-libs/zlib
	media-libs/alsa-lib
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-x86

src_prepare() {
	sed -i \
		-e '/strip/d' \
		-e '/^CC/d' \
		-e '/CC/s/$/ $(LDFLAGS)/' \
		-e 's/@//' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	newgamesbin xe xe.bin || die "newgamesbin failed"
	newgamesbin "${FILESDIR}"/xe-${PV} xe || die "newgamesbin failed"
	sed -i \
		-e "s:GENTOODIR:$(games_get_libdir)/${PN}:" "${D}/${GAMES_BINDIR}/xe" \
		|| die "sed failed"
	insinto "$(games_get_libdir)"/${PN}
	doins -r modules/ rc/ || die "doins failed"
	keepdir "$(games_get_libdir)"/${PN}/bios
	dodoc README.txt
	dohtml manual.html
	prepgamesdirs
}
