# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ldapdns/ldapdns-2.05.ebuild,v 1.10 2007/07/15 03:31:10 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A tiny, fast authoritative nameserver that queries LDAP and can be updated instantly"
SRC_URI="http://www.nimh.org/dl/${P}.tar.gz"
HOMEPAGE="http://www.nimh.org/code/ldapdns/"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/libc
	>=net-nds/openldap-2"
RDEPEND="${DEPEND}
	>=sys-process/daemontools-0.70
	sys-apps/ucspi-tcp"

src_compile() {
	local myconf="--prefix=/usr "

	cd ${S}
	./configure ${myconf}
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc AUTHORS CHANGELOG FAQ INSTALL  COPYING NEWS README* TODO
}

pkg_postinst() {
	enewgroup nofiles
	enewuser ldapdns -1 -1 /nonexistent nofiles
	enewuser dnslog -1 -1 /nonexistent nofiles

	elog "Read the readme.configure and use ldapdns-conf to setup"
}
