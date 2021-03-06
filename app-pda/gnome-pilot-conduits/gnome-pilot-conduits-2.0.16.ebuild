# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot-conduits/gnome-pilot-conduits-2.0.16.ebuild,v 1.5 2008/08/01 19:17:50 nixnut Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://live.gnome.org/GnomePilot"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2.0
	>=app-pda/gnome-pilot-${PVR}
	>=dev-libs/libxml2-2.5"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	${RDEPEND}"

G2CONF="${G2CONF} --enable-pilotlinktest"
SCROLLKEEPER_UPDATE="0"

src_unpack() {
	gnome2_src_unpack

	# fix build failures
	sed -i "s:pi-md5.h:libpisock/pi-md5.h:g" \
		mal-conduit/mal/common/AG{Digest,MD5}.c || die "sed failed"
}
