# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsq/cvsq-0.4.4.ebuild,v 1.6 2005/04/25 11:23:51 ka0ttic Exp $

IUSE=""

DESCRIPTION="cvsq is a tool that enables developers with a dial-up connection to work comfortably with CVS by queuing the commits."
SRC_URI="http://metawire.org/~vslavik/sw/cvsq/download/${P}.tar.gz"
HOMEPAGE="http://metawire.org/~vslavik/sw/cvsq/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ~ppc"

DEPEND=""		# This is just a shell script.
RDEPEND="dev-util/cvs
		app-shells/bash
		sys-apps/coreutils"

src_install () {
	dodir /usr/bin
	dobin cvsq
	dodoc README AUTHORS ChangeLog
}
