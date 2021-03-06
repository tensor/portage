# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-bin/freebsd-bin-7.1-r1.ebuild,v 1.1 2009/05/18 17:00:46 flameeyes Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD /bin tools"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	dev-libs/libedit
	sys-libs/ncurses
	sys-apps/ed
	!app-admin/realpath"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	>=sys-devel/flex-2.5.31-r2"

S=${WORKDIR}/bin

PATCHES="${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"

# csh and tcsh are provided by tcsh package, rmail is sendmail stuff.
REMOVE_SUBDIRS="csh rmail ed"

pkg_setup() {
	mymakeopts="${mymakeopts} WITHOUT_TCSH= WITHOUT_SENDMAIL= WITHOUT_RCMDS= "
}
