# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/suspend/suspend-0.8-r1.ebuild,v 1.3 2009/05/10 22:31:29 dragonheart Exp $

EAPI=2
inherit eutils

DESCRIPTION="Userspace Software Suspend and S2Ram"
HOMEPAGE="http://suspend.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fbsplash crypt"

X86_RDEPEND="dev-libs/libx86"
X86_DEPEND="
	${X86_RDEPEND}
	>=sys-apps/pciutils-2.2.4"
RDEPEND=">=dev-libs/lzo-2
	fbsplash? ( >=media-gfx/splashutils-1.5.2 )
	crypt? ( dev-libs/libgcrypt )
	x86? ( ${X86_RDEPEND} )
	amd64? ( ${X86_RDEPEND} )"
DEPEND="${RDEPEND}
	x86? ( ${X86_DEPEND} )
	amd64? ( ${X86_DEPEND} )
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/suspend-overflow-gentoo.patch
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-compress \
		$(use_enable crypt encrypt) \
		$(use_enable fbsplash) \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	prepalldocs
}

pkg_postinst() {
	elog "In order to make this package work with genkernel see:"
	elog "http://bugs.gentoo.org/show_bug.cgi?id=156445"
}
