# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/radmind/radmind-1.7.1-r1.ebuild,v 1.3 2009/08/03 22:40:44 flameeyes Exp $

inherit eutils

DESCRIPTION="A suite of Unix command-line tools and a server designed to remotely administer the file systems of multiple Unix machines."
HOMEPAGE="http://rsug.itd.umich.edu/software/radmind/"
SRC_URI="mirror://sourceforge/radmind/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.7.0-gentoo.patch
	# remove dnssd as it doesn't compile
	epatch "${FILESDIR}"/${P}-dnssd.patch
}

src_compile() {
	econf $(use_with ssl) || die "econf failed"
	# bug #239862
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README VERSION COPYRIGHT
}
