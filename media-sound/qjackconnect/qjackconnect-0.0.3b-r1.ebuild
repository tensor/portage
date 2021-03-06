# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackconnect/qjackconnect-0.0.3b-r1.ebuild,v 1.19 2008/07/27 21:16:23 carlo Exp $

EAPI=1

inherit qt3 toolchain-funcs

IUSE=""

DESCRIPTION="A QT based patchbay for the JACK Audio Connection Kit"
HOMEPAGE="http://www.suse.de/~mana/jack.html"
SRC_URI="ftp://ftp.suse.com/pub/people/mana/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="x11-libs/qt:3
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed \
		-e "s:/usr/lib/qt3:/usr/qt/3:" \
		-e "s:-O2 -g:${CXXFLAGS}:" \
		-e "s:gcc -g -o ${PN}:\$(CXX) \$(LDFLAGS) -o ${PN}:" \
		< make_qjackconnect > Makefile
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die
}

src_install() {
	dobin qjackconnect
}
