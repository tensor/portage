# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/matew/matew-1.9.ebuild,v 1.6 2007/01/02 23:10:13 rl03 Exp $

DESCRIPTION="Make Album The Easy Way"
HOMEPAGE="http://matew.sourceforge.net/"
SRC_URI="mirror://sourceforge/matew/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	media-gfx/imagemagick
	app-shells/bash
	sys-apps/coreutils
"

src_install() {
	dobin ${S}/src/matew ${S}/src/matew-cleanup ${S}/src/matew-wizard
	insinto /etc/matew/styles
	doins ${S}/src/styles/*
	insinto /etc/matew/languages
	doins ${S}/src/languages/*
	dodoc ${S}/doc/AUTHOR ${S}/doc/ChangeLog ${S}/doc/README ${S}/doc/THANKS ${S}/doc/TODO
	doman ${S}/doc/man/matew.1.gz
}

pkg_postinst() {
	elog "Matew files installed successfully!"
	elog "Run matew-wizard and read instructions."
}
