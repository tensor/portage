# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cunit/cunit-1.1.0.1-r1.ebuild,v 1.1 2005/04/12 08:00:14 dholm Exp $

inherit eutils

S=${WORKDIR}/CUnit-1.1-1
DESCRIPTION="CUnit - C Unit Test Framework"
# Note: Upstream authors have sucky versioning scheme. We fake.
SRC_URI="mirror://sourceforge/cunit/CUnit-1.1-1.tar.gz"
HOMEPAGE="http://cunit.sourceforge.net"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-const.patch
}

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
