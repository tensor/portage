# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtkcdlabel/gtkcdlabel-1.14.ebuild,v 1.1 2009/04/30 18:06:18 ssuominen Exp $

DESCRIPTION="a GUI frontend to cdlabelgen which is a program that can generate a variety of CD tray covers."
HOMEPAGE="http://gtkcdlabel.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	>=app-cdr/cdlabelgen-4
	dev-python/pygtk"
DEPEND=""

src_install() {
	dobin usr/bin/${PN}.py || die "dobin failed"
	insinto /usr/share
	doins -r usr/share/{applications,${PN},pixmaps} || die "doins failed"
	dodoc usr/share/doc/${PN}/{AUTHORS,README}
}
