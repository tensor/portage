# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.24.0.ebuild,v 1.7 2009/07/23 21:41:10 eva Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Gnome hexadecimal editor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
	dev-libs/popt
	>=dev-libs/atk-1
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/gail-0.17"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} --disable-static"
