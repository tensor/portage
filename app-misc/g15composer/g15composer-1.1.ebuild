# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15composer/g15composer-1.1.ebuild,v 1.7 2007/03/15 10:44:39 rbu Exp $

inherit eutils

DESCRIPTION="A library to render text and shapes into a buffer usable by the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="truetype"

RDEPEND="app-misc/g15daemon
	dev-libs/libg15render
	truetype? ( media-libs/freetype )"

DEPEND="${RDEPEND}
	dev-libs/libg15"

RDEPEND="${RDEPEND}
	sys-apps/coreutils"

pkg_setup() {
	if use truetype && ! built_with_use dev-libs/libg15render truetype ; then
		eerror "dev-libs/libg15render must be built with USE=\"truetype\" for truetype to work."
		die "Please rebuild the package with corrected USE flags."
	fi
}

src_compile() {
	econf \
		$(use_enable truetype ttf ) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}/${P}.initd" g15composer

	dodoc AUTHORS README ChangeLog
}
