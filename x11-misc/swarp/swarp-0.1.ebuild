# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="simple pointer warp"
HOMEPAGE="http://tools.suckless.org/view/x+tools"
SRC_URI="http://suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/.*strip.*//" \
		Makefile || die "sed failed"

	sed -i \
		-e "s/CFLAGS = -Os/CFLAGS +=/" \
		-e "s/LDFLAGS =/LDFLAGS +=/" \
		config.mk || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	dodoc README
}
