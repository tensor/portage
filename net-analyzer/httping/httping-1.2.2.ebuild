# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.2.ebuild,v 1.6 2008/01/27 19:13:31 cedk Exp $

inherit toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa mips ~ppc ppc64 x86"
IUSE="ssl"

DEPEND=">=sys-libs/ncurses-5"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	local makefile
	use ssl || makefile="-f Makefile.nossl"
	export CC="$(tc-getCC)"
	emake ${makefile} || die "make failed"
}

src_install() {
	dobin httping || die
	dodoc readme.txt
}
