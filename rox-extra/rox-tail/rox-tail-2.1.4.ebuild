# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-tail/rox-tail-2.1.4.ebuild,v 1.4 2007/11/16 15:25:23 drac Exp $

ROX_CLIB_VER="2.1.8"
inherit rox

MY_PN="Tail"
DESCRIPTION="Tail is a ROX Application to monitor file changes a la \`tail -f\'"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/tail.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

APPNAME=${MY_PN}
S=${WORKDIR}
