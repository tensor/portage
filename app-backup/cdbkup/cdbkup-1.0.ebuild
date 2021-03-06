# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/cdbkup/cdbkup-1.0.ebuild,v 1.3 2008/10/04 15:44:18 gentoofan23 Exp $

inherit eutils

DESCRIPTION="performs full/incremental backups of local/remote filesystems onto CD-R(W)s"
HOMEPAGE="http://cdbkup.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdbkup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/libc
	virtual/cdrtools
	>=sys-apps/eject-2.0.10
	!app-misc/cdcat"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd "${S}"

	sed -i \
		-e "s:doc/cdbkup:doc/${P}:" Makefile.in \
			|| die "sed Makefile.in failed"

	#apply the patch
	epatch "${S}"/linuxtar_13.patch
}

src_compile() {
	econf --with-snardir=/etc/cdbkup --with-dumpgrp=users || die "econf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc COMPLIANCE ChangeLog README TODO
}
