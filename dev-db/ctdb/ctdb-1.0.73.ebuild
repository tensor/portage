# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/ctdb/ctdb-1.0.73.ebuild,v 1.2 2009/06/26 18:52:11 patrick Exp $

EAPI="2"

inherit autotools

DESCRIPTION="A cluster implementation of the TDB database used by Samba and other projects to store temporary data."
HOMEPAGE="http://ctdb.samba.org/"
SRC_URI="http://ctdb.samba.org/packages/redhat/RHEL5/${P}.tgz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/popt"
RDEPEND="${DEPEND}"

src_prepare() {
	AT_M4DIR="-I ${S}/lib/replace -I ${S}/lib/talloc -I ${S}/lib/tdb -I ${S}/lib/popt -I ${S}/lib/events"
	autotools_run_tool autoheader ${AT_M4DIR} || die "running autoheader failed"
	eautoconf ${AT_M4DIR}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc "${D}/usr/share/doc/ctdb/README.eventscripts"
	rm -rf "${D}/usr/share/doc/ctdb"

	dohtml web/* doc/*.html
}
