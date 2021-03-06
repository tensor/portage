# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/matroxset/matroxset-0.3.ebuild,v 1.9 2007/11/27 12:15:19 zzam Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="Matrox utility to switch output modes (activate tvout)"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/${P}.tar.gz"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"

src_compile() {
#	make clean || die
	make all || die

	#prepare small README
	cat >> "${S}"/README << _EOF_
This utility has been created by Petr Vandrovec

Not much info here, but here are some pointers
http://davedina.apestaart.org/download/doc/Matrox-TVOUT-HOWTO-0.1.txt
http://www3.sympatico.ca/dan.eriksen/matrox_tvout/g450_tvout_howto.html
http://www.netnode.de/howto/matrox-fb.html
_EOF_
}

src_install() {
	dobin matroxset

	dodoc README
}
