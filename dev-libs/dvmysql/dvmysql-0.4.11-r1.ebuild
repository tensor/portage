# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvmysql/dvmysql-0.4.11-r1.ebuild,v 1.4 2006/11/23 20:15:08 vivo Exp $

inherit eutils

DESCRIPTION="dvmysql provides a C++ interface to mysql"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE="doc"

DEPEND="virtual/mysql
	dev-libs/dvutil"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-underquoted-m4.diff

	# install API docs only if USE=doc
	sed -i 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS

	if use doc ; then
		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
