# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/redir/redir-2.2.1.ebuild,v 1.8 2009/05/30 02:00:17 darkside Exp $

inherit toolchain-funcs

DESCRIPTION="Redir is a port redirector."
HOMEPAGE="http://sammy.net/~sammy/hacks/"
SRC_URI="http://sammy.net/~sammy/hacks/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~mips sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin redir || die "dobin failed"
	newman redir.man redir.1 || die "doman failed"
	dodoc CHANGES README transproxy.txt || die "dodoc failed"
}
