# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpager/wmpager-1.2-r1.ebuild,v 1.11 2007/07/22 04:41:20 dberkholz Exp $

IUSE=""
DESCRIPTION="A simple pager docklet for the WindowMaker window manager."
HOMEPAGE="http://wmpager.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpager/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~sparc x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext
	virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	sed -i "s:\(WMPAGER_DEFAULT_INSTALL_DIR \).*:\1\"/usr/share/wmpager\":" \
		src/wmpager.c

	emake || die
}

src_install() {
	make INSTALLDIR=${D}/usr install || die

	rm -rf ${D}/usr/man
	doman man/man1/*.1x
	dodoc README
}
