# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/datapipe/datapipe-1.0.ebuild,v 1.7 2008/09/14 08:03:15 solar Exp $

inherit toolchain-funcs

IUSE=""
DESCRIPTION="bind a local port and connect it to a remote socket"
HOMEPAGE="http://http.distributed.net/pub/dcti/unsupported/"
SRC_URI="ftp://ftp.distributed.net/pub/dcti/unsupported/${P}.tar.gz http://http.distributed.net/pub/dcti/unsupported/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~arm ~amd64"

src_compile() {
	$(tc-getCC) ${CFLAGS} -o datapipe datapipe.c
}

src_install() {
	dobin datapipe
	dodoc datapipe.txt
}
