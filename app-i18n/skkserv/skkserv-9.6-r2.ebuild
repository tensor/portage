# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkserv/skkserv-9.6-r2.ebuild,v 1.12 2007/04/28 21:54:47 swegener Exp $

inherit eutils

MY_P="skk${PV}mu"

DESCRIPTION="Dictionary server for the SKK Japanese-input software"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/museum/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc
	>=app-i18n/skk-jisyo-200210"
PROVIDE="virtual/skkserv"

S="${WORKDIR}/skk-${PV}mu"

src_unpack() {
	unpack ${A}
	cd ${S}/skkserv
	epatch ${FILESDIR}/${P}-segfault-gentoo.patch
}

src_compile() {
	econf --libexecdir=/usr/sbin || die "econf failed"
	cd skkserv
	emake || die
}

src_install() {
	cd skkserv
	dosbin skkserv || die

	# install rc script
	newinitd ${FILESDIR}/skkserv.initd skkserv
}
