# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pbzip2/pbzip2-1.0.5-r1.ebuild,v 1.7 2009/08/09 15:37:00 ranger Exp $

inherit multilib eutils

DESCRIPTION="parallel bzip2 (de)compressor using libbz2"
HOMEPAGE="http://compression.ca/pbzip2/"
SRC_URI="http://compression.ca/${PN}/${P}.tar.gz"

LICENSE="PBZIP2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="static"

DEPEND="app-arch/bzip2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	sed -e 's:^CFLAGS = .*$:#&:g' -e 's:g++:$(CXX):g' -i ${P}/Makefile || die
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	tc-export CXX
	if use static ; then
		cp -f /usr/$(get_libdir)/libbz2.a "${S}"
		emake pbzip2-static || die "Failed to build"
	else
		emake pbzip2 || die "Failed to build"
	fi
}

src_install() {
	dobin pbzip2 || die "Failed to install"
	dodoc AUTHORS ChangeLog README
	doman pbzip2.1 || die "Failed to install man page"
	dosym /usr/bin/pbzip2 /usr/bin/pbunzip2
}
