# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ucarp/ucarp-1.3.ebuild,v 1.1 2007/09/20 08:46:04 xmerlin Exp $

inherit eutils

DESCRIPTION="Portable userland implementation of Common Address Redundancy Protocol (CARP)."
HOMEPAGE="http://www.ucarp.org"
LICENSE="GPL-2"
DEPEND="virtual/libpcap"
SRC_URI="ftp://ftp.ucarp.org/pub/ucarp/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die

	dodoc README INSTALL NEWS ChangeLog || die
	dodoc examples/linux/vip-up.sh examples/linux/vip-down.sh
}
