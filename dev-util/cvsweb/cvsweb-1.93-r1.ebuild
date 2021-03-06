# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsweb/cvsweb-1.93-r1.ebuild,v 1.2 2005/04/16 00:40:23 beu Exp $

DESCRIPTION="WWW interface to a CVS tree"
HOMEPAGE="http://www.freebsd.org/projects/cvsweb.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

RDEPEND=">=dev-lang/perl-5
	>=app-text/rcs-5.7"

S="${WORKDIR}/cvsweb"

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/web/apache/conf/:/etc/httpd/:" cvsweb.cgi cvsweb.conf
}

src_install() {
	insinto /etc/httpd
	doins cvsweb.conf
	exeinto /usr/httpd/cgi-bin
	doexe cvsweb.cgi
	dodoc README TODO
}
