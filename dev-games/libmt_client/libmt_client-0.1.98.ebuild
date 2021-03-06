# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libmt_client/libmt_client-0.1.98.ebuild,v 1.7 2005/01/01 18:01:32 eradicator Exp $

DESCRIPTION="backend library for the maitretarot clients"
HOMEPAGE="http://www.nongnu.org/maitretarot/"
SRC_URI="http://savannah.nongnu.org/download/maitretarot/${PN}.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="=dev-libs/glib-2*
	dev-libs/libxml2
	dev-games/libmaitretarot"

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
