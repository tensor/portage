# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipsak/sipsak-0.8.6.ebuild,v 1.9 2005/07/30 18:34:10 swegener Exp $

IUSE=""

DESCRIPTION="small command line tool for testing SIP applications and devices"
HOMEPAGE="http://sipsak.berlios.de/"
SRC_URI="http://download.berlios.de/sipsak/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/libc"

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
