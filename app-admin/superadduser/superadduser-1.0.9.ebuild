# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0.9.ebuild,v 1.14 2008/04/24 04:44:10 ricmm Exp $

DESCRIPTION="Interactive adduser script from Slackware"
HOMEPAGE="http://www.interlude.org.uk/unix/slackware/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/shadow"

src_install() {
	dosbin ${FILESDIR}/${PV}/superadduser || die
	doman ${FILESDIR}/superadduser.8
}
