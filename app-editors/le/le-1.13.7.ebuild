# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/le/le-1.13.7.ebuild,v 1.1 2008/03/26 19:14:09 truedfx Exp $

DESCRIPTION="Terminal text editor"
HOMEPAGE="http://www.gnu.org/directory/text/editors/le-editor.html"
SRC_URI="ftp://ftp.yars.free.net/pub/source/le/le-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r5"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog FEATURES HISTORY INSTALL NEWS README TODO
}
