# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-2.18.2.ebuild,v 1.2 2009/08/08 23:13:27 eva Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GTK+2 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="accessibility"

RDEPEND=">=x11-libs/gtk+-2.12"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.31
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --enable-animation --enable-lua"
	use accessibility || G2CONF="${G2CONF} --disable-hc"
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in || die "sed failed"
}
