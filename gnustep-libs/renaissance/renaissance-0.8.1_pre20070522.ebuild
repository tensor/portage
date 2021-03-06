# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.8.1_pre20070522.ebuild,v 1.6 2007/11/16 15:11:26 beandog Exp $

inherit gnustep-2

DESCRIPTION="GNUstep Renaissance allows to describe user interfaces XML files"
HOMEPAGE="http://www.gnustep.it/Renaissance/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="amd64 ppc x86"
LICENSE="LGPL-2.1"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-docpath.patch
}
