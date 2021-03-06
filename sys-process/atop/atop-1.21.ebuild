# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/atop/atop-1.21.ebuild,v 1.5 2007/11/28 18:33:25 opfer Exp $

DESCRIPTION="Resource-specific view of processes"
HOMEPAGE="http://www.atcomputing.nl/Tools/atop"
SRC_URI="http://www.atconsultancy.nl/atop/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND="sys-process/acct"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CFLAGS/s: = -O : += :' \
		-e '/^LDFLAGS/s: = : += :' \
		Makefile
	cp "${FILESDIR}"/atop.rc atop.init
	chmod a+rx atop.init
	sed -i 's: root : :' atop.cron #191926
}

src_install() {
	emake DESTDIR="${D}" INIPATH=/etc/init.d install || die
	dodoc README
}
