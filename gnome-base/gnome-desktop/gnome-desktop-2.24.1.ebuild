# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.24.1.ebuild,v 1.1 2008/10/22 22:42:29 eva Exp $

inherit gnome2

DESCRIPTION="Libraries for the gnome desktop that are not part of the UI"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-libs/libxml2-2.4.20
		 >=x11-libs/gtk+-2.11.3
		 >=dev-libs/glib-2.15.4
		 >=x11-libs/libXrandr-1.2
		 >=gnome-base/gconf-2
		 >=gnome-base/libgnomeui-2.6
		 >=x11-libs/startup-notification-0.5"
DEPEND="${RDEPEND}
		app-text/scrollkeeper
		>=dev-util/intltool-0.40
		>=dev-util/pkgconfig-0.9
		>=app-text/gnome-doc-utils-0.3.2
		doc? ( >=dev-util/gtk-doc-1.4 )
		~app-text/docbook-xml-dtd-4.1.2
		x11-proto/xproto"
# Includes X11/Xatom.h in libgnome-desktop/gnome-bg.c which comes from xproto

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --with-gnome-distributor=Gentoo --disable-scrollkeeper"
}