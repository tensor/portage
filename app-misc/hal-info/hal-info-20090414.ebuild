# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/hal-info-20090414.ebuild,v 1.7 2009/07/19 12:57:41 nixnut Exp $

inherit eutils

DESCRIPTION="The fdi scripts that HAL uses"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-apps/hal-0.5.10"
DEPEND="${RDEPEND}"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed."
}
