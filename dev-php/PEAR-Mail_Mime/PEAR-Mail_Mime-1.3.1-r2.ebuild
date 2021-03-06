# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Mail_Mime/PEAR-Mail_Mime-1.3.1-r2.ebuild,v 1.10 2008/01/10 10:06:32 vapier Exp $

inherit php-pear-r1 eutils

DESCRIPTION="Provides classes to deal with creation and manipulation of mime messages"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix DOS encodings
	edos2unix *

	epatch "${FILESDIR}"/php-pass-by-reference-fix.patch #125451
}
