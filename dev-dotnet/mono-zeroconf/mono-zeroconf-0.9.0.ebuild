# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-zeroconf/mono-zeroconf-0.9.0.ebuild,v 1.3 2009/07/02 19:24:25 maekke Exp $

EAPI=2

inherit base mono

DESCRIPTION="a cross platform Zero Configuration Networking library for Mono and .NET."
HOMEPAGE="http://www.mono-project.com/Mono.Zeroconf"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc +avahi"

RDEPEND=">=dev-lang/mono-2.0
	avahi? ( >=net-dns/avahi-0.6[mono] )
	!avahi? ( net-misc/mDNSResponder )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable doc docs) $(use_enable avahi) $(use_enable !avahi mdnsresponder)
}

src_compile() {
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README || die "docs failed"
	mono_multilib_comply
}
