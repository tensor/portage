# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnut/libnut-661.ebuild,v 1.5 2009/08/04 16:35:38 jer Exp $

inherit flag-o-matic

DESCRIPTION="Library and tools to create NUT multimedia files"
HOMEPAGE="http://svn.mplayerhq.hu/nut/
	http://wiki.multimedia.cx/index.php?title=NUT
	http://www.nut-container.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	emake PREFIX="${D}/usr" install || die "make install died"
	dodoc README
	cd "${S}"/nututils
	dobin nutindex nutmerge nutparse
}
