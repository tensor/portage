# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipcalc/sipcalc-1.1.4.ebuild,v 1.3 2008/03/25 16:52:17 armin76 Exp $

DESCRIPTION="Sipcalc is an advanced console-based IP subnet calculator."
HOMEPAGE="http://www.routemeister.net/projects/sipcalc/"
SRC_URI="http://www.routemeister.net/projects/${PN}/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS NEWS README TODO
}
