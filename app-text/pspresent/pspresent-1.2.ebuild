# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pspresent/pspresent-1.2.ebuild,v 1.10 2007/07/22 10:24:50 omp Exp $

IUSE="xinerama"

DESCRIPTION="A tool to display full-screen PostScript presentations."
SRC_URI="http://www.cse.unsw.edu.au/~matthewc/pspresent/${P}.tar.gz"
HOMEPAGE="http://www.cse.unsw.edu.au/~matthewc/pspresent/"

RDEPEND="virtual/libc
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )
	virtual/ghostscript"
DEPEND="${RDEPEND}
	x11-proto/xproto
	xinerama? ( x11-proto/xineramaproto )
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"

src_compile()
{
	if ! use xinerama ; then
		sed -i -e "/^XINERAMA/s/^/#/g" Makefile
	fi
	make pspresent || die "make failed"
}

src_install()
{
	dobin pspresent
	doman pspresent.1
}
