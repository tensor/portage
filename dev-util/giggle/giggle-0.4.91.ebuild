# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/giggle/giggle-0.4.91.ebuild,v 1.3 2009/04/29 10:16:16 ikelos Exp $

EAPI="1"

inherit autotools gnome2

DESCRIPTION="GTK+ Frontend for GIT"
HOMEPAGE="http://live.gnome.org/giggle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="eds"

RDEPEND=">=dev-util/git-1.4.4.3
		 >=dev-libs/glib-2.18
		 >=x11-libs/gtk+-2.10
		 x11-libs/gtksourceview:2.0
		 eds? ( gnome-extra/evolution-data-server )
		 >=gnome-base/libglade-2.4"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/pkgconfig-0.15
		>=dev-util/intltool-0.35
		>=sys-devel/libtool-2"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="$(use_enable eds evolution-data-server)"

src_unpack() {
	gnome2_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${P}-libgiggle.patch"
	eautoreconf
}
