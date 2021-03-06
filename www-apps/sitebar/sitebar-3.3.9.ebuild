# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/sitebar/sitebar-3.3.9.ebuild,v 1.2 2007/10/18 17:03:31 dertobi123 Exp $

inherit webapp eutils

DESCRIPTION="The Bookmark Server for Personal and Team Use"
HOMEPAGE="http://sitebar.sourceforge.net/"
KEYWORDS="~amd64 ppc ~x86"

IUSE=""
MY_PN=${PN/sitebar/SiteBar}
S=${WORKDIR}/${MY_PN}-${PV}

SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"

DEPEND="www-servers/apache
		virtual/php"
LICENSE="GPL-2"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_install() {
	webapp_src_preinst
	dodoc readme.txt doc/history.txt doc/install.txt doc/troubleshooting.txt
	cp -R . "${D}"/"${MY_HTDOCSDIR}"
	rm -rf "${D}"/"${MY_HTDOCSDIR}"/doc "${D}"/"${MY_HTDOCSDIR}"/readme.txt

	webapp_serverowned "${MY_HTDOCSDIR}"/inc
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
