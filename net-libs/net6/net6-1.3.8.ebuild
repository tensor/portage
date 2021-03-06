# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/net6/net6-1.3.8.ebuild,v 1.1 2008/11/07 21:02:03 humpback Exp $

DESCRIPTION="Network access framework for IPv4/IPv6 written in C++"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/libsigc++-2.0
		 >=net-libs/gnutls-1.2.10"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.20
		nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
