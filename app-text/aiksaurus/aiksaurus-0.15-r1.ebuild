# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aiksaurus/aiksaurus-0.15-r1.ebuild,v 1.17 2005/10/05 20:27:31 blubb Exp $

inherit flag-o-matic eutils multilib

S=${WORKDIR}/Aiksaurus-${PV}
DESCRIPTION="A thesaurus lib, tool and database"
HOMEPAGE="http://www.aiksaurus.com/"
SRC_URI="http://www.aiksaurus.com/dist/TAR/Aiksaurus-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	filter-flags -fno-exceptions
	./configure --prefix=/usr --libdir=/usr/$(get_libdir) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} LIBDIR=${D}/usr/$(get_libdir) install || die
}
