# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug-client/xdebug-client-2.0.3.ebuild,v 1.2 2008/07/15 18:21:46 jer Exp $

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

MY_PV="${PV/_/}"
MY_PV="${MY_PV/rc/RC}"

DESCRIPTION="Xdebug client for the Common Debugger Protocol (DBGP)."
HOMEPAGE="http://www.xdebug.org/"
SRC_URI="http://pecl.php.net/get/xdebug-${MY_PV}.tgz"
LICENSE="Xdebug"
SLOT="0"
IUSE="libedit"

S="${WORKDIR}/xdebug-${MY_PV}/debugclient"

DEPEND="libedit? ( || ( dev-libs/libedit sys-freebsd/freebsd-lib ) )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	chmod +x "${S}"/configure
}

src_compile() {
	econf $(use_with libedit) --disable-dependency-tracking
	emake || die "Build of debug client failed!"
}

src_install() {
	newbin debugclient xdebug
}
