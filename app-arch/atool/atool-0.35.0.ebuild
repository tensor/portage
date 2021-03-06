# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.35.0.ebuild,v 1.6 2008/09/06 15:30:49 nixnut Exp $

DESCRIPTION="a script for managing file archives of various types"
HOMEPAGE="http://www.nongnu.org/atool/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	!app-text/adiff"

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
	dodoc AUTHORS ChangeLog NEWS README TODO
}
