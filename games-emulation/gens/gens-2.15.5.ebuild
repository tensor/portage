# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.15.5.ebuild,v 1.2 2009/02/04 15:39:31 tupone Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://gens.consolemul.com/"
SRC_URI="mirror://sourceforge/gens/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2
	>=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

src_prepare() {
	epatch "${FILESDIR}"/${P}-romsdir.patch \
		"${FILESDIR}"/${P}-as-needed.patch
	append-ldflags -Wl,-z,noexecstack
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS README
	prepgamesdirs
}
