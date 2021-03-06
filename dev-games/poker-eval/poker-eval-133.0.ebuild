# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/poker-eval/poker-eval-133.0.ebuild,v 1.3 2006/11/19 22:27:16 ticho Exp $

DESCRIPTION="A fast C library for evaluating poker hands."
HOMEPAGE="http://pokersource.org/"
SRC_URI="http://download.gna.org/pokersource/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO WHATS-HERE
}
