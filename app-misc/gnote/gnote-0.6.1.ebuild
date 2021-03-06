# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnote/gnote-0.6.1.ebuild,v 1.1 2009/08/02 22:42:06 eva Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="applet debug" # dbus

RDEPEND=">=x11-libs/gtk+-2.14
	>=dev-cpp/glibmm-2
	>=dev-cpp/gtkmm-2.12
	>=dev-libs/libxml2-2
	dev-libs/libxslt
	>=gnome-base/gconf-2
	>=dev-libs/libpcre-7.8[cxx]
	>=app-text/gtkspell-2.0.9
	>=dev-libs/boost-1.34
	sys-libs/e2fsprogs-libs
	>=gnome-base/gnome-panel-2
	applet? ( >=dev-cpp/libpanelappletmm-2.26 )"
# Build with dbus is currently not implemented
#	dbus? ( >=dev-libs/dbus-glib-0.70 )"
DEPEND="${DEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0
	app-text/gnome-doc-utils"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	gnome2_src_prepare

	# Fix dbus configure switch, upstream bug #590560
	epatch "${FILESDIR}/${P}-dbus-switch.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-dbus
		--disable-static
		$(use_enable applet)
		$(use_enable debug)"
}
