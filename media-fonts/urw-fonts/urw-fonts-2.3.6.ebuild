# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urw-fonts/urw-fonts-2.3.6.ebuild,v 1.9 2008/06/21 06:01:53 pva Exp $

inherit eutils rpm font versionator

MY_PV=$(replace_version_separator 2 -)

DESCRIPTION="free good quality fonts gpl'd by URW++"
HOMEPAGE="http://www.urwpp.de/"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.1.1.src.rpm"

KEYWORDS="alpha amd64 arm ia64 ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

S=${WORKDIR}
FONT_S=${S}
FONT_SUFFIX="afm pfb"
DOCS="ChangeLog README* TODO"

pkg_postinst() {
	font_pkg_postinst
	elog "If you upgraded from ${PN}-2.1-r2 some fonts will look a bit"
	elog "differently. Take a look at bug #208990 if interested."
}
