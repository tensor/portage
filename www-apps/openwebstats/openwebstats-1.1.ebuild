# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/openwebstats/openwebstats-1.1.ebuild,v 1.4 2007/01/02 22:43:39 rl03 Exp $

inherit webapp

DESCRIPTION="OpenWebStats is a PHP stats application that reads Apache log files and imports the data to a MySQL database."
HOMEPAGE="http://openwebstats.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/php"

S=${WORKDIR}/${PN}

src_install() {
	webapp_src_preinst

	dodoc README

	## Main application
	cp -r . ${D}${MY_HTDOCSDIR}
	cp ${FILESDIR}/config.php ${D}${MY_HTDOCSDIR}/

	## Docs installed, remove unnecessary files
	rm -f ${D}${MY_HTDOCSDIR}/README
	rm -f ${D}${MY_HTDOCSDIR}/CHANGELOG

	# Database creation
	webapp_sqlscript mysql ${D}${MY_HTDOCSDIR}/openwebstats.sql

	# Postinstall instructions
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
