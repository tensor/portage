# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.20.ebuild,v 1.1 2008/09/17 09:44:22 vapier Exp $

DESCRIPTION="Prints out location of specified executables that are in your path"
HOMEPAGE="http://www.xs4all.nl/~carlo17/which/"
SRC_URI="http://www.xs4all.nl/~carlo17/which/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS EXAMPLES NEWS README*
}
