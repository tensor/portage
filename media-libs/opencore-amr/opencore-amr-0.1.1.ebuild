# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opencore-amr/opencore-amr-0.1.1.ebuild,v 1.3 2009/08/04 17:27:21 jer Exp $

EAPI=2

inherit toolchain-funcs eutils multilib

DESCRIPTION="Implementation of Adaptive Multi Rate Narrowband and Wideband speech codec"
HOMEPAGE="http://opencore-amr.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}/${P}-pic.patch"
	epatch "${FILESDIR}/${P}-libdir.patch"
}

src_compile() {
	tc-export CC CXX
	emake || die
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" LIBDIR="$(get_libdir)" install || die
}
