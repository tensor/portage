# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-nat/mono-nat-1.0.1.ebuild,v 1.4 2009/07/21 19:07:53 fauli Exp $

EAPI=2

inherit mono multilib

MY_PN=Mono.Nat

DESCRIPTION="Mono.Nat is a C# library used for automatic port forwarding, using either uPnP or nat-pmp."
HOMEPAGE="http://projects.qnetp.net/projects/show/mono-nat"
SRC_URI="http://projects.qnetp.net/attachments/download/20/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=dev-lang/mono-2.0.1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"

src_compile() {
	emake -j1 ASSEMBLY_COMPILER_COMMAND="/usr/bin/gmcs -keyfile:${FILESDIR}/mono.snk"
}

src_install() {
	egacinstall $(find . -name "Mono.Nat.dll")
	dodir /usr/$(get_libdir)/pkgconfig
	ebegin "Installing .pc file"
	sed  \
		-e "s:@LIBDIR@:$(get_libdir):" \
		-e "s:@PACKAGENAME@:${MY_PN}:" \
		-e "s:@DESCRIPTION@:${DESCRIPTION}:" \
		-e "s:@VERSION@:${PV}:" \
		-e 's;@LIBS@;-r:${libdir}/mono/mono-nat/Mono.Nat.dll;' \
		"${FILESDIR}"/${PN}.pc.in > "${D}"/usr/$(get_libdir)/pkgconfig/mono.nat.pc \
		|| die "sed failed"
	PKG_CONFIG_PATH="${D}/usr/$(get_libdir)/pkgconfig/" pkg-config --exists mono.nat || die ".pc file failed to validate."
	eend $?
}
