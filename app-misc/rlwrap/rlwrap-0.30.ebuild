# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rlwrap/rlwrap-0.30.ebuild,v 1.1 2008/03/27 10:01:44 hkbst Exp $

DESCRIPTION="GNU readline wrapper"
HOMEPAGE="http://utopia.knoware.nl/~hlub/uck/rlwrap"
SRC_URI="http://utopia.knoware.nl/~hlub/uck/rlwrap/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="debug"

DEPEND="sys-libs/readline"

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
