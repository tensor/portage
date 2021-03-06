# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ps2-packer/ps2-packer-0.4.4.ebuild,v 1.4 2009/03/31 06:34:27 vapier Exp $

inherit games

DESCRIPTION="another ELF packer for the PS2"
HOMEPAGE="http://ps2dev.org/kb.x?T=1061"
SRC_URI="http://ps2dev.org/files/${P}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

QA_TEXTRELS="
	${GAMES_PREFIX_OPT:1}/ps2-packer/n2e-packer.so
	${GAMES_PREFIX_OPT:1}/ps2-packer/n2d-packer.so
	${GAMES_PREFIX_OPT:1}/ps2-packer/n2b-packer.so"

QA_WX_LOAD="
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2e-0088-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/lzo-0088-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2e-asm-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/null-0088-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2e-asm-one-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2e-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/zlib-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2b-0088-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2d-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/null-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2b-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/zlib-0088-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/lzo-1d00-stub
	${GAMES_PREFIX_OPT:1}/ps2-packer/stub/n2d-0088-stub"

DEPEND="sys-libs/glibc"

S=${WORKDIR}

src_install() {
	rm -f COPYING
	insinto ${GAMES_PREFIX_OPT}/${PN}
	doins -r README.txt stub || die "doins"
	exeinto ${GAMES_PREFIX_OPT}/${PN}
	doexe *.so ps2-packer || die "doexe"

	dodir ${GAMES_PREFIX_OPT}/bin
	dosym ${GAMES_PREFIX_OPT}/{${PN},bin}/ps2-packer
}
