# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/delay/delay-1.6.ebuild,v 1.19 2009/06/16 18:05:05 klausman Exp $

inherit toolchain-funcs

DESCRIPTION="sleeplike program that counts down the number of seconds specified"
HOMEPAGE="http://onegeek.org/~tom/software/delay/"
SRC_URI="http://onegeek.org/~tom/software/delay/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	sed -i -e "s/#include <stdio.h>/&\n#include <stdlib.h>/" delay.c
	tc-export CC
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README INSTALL
}
