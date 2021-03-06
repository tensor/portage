# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-0.14.0.ebuild,v 1.1 2008/03/29 20:46:08 compnerd Exp $

inherit gnome2 eutils autotools

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="bluetooth eds gajim pidgin sylpheed thunderbird"

RDEPEND=">=x11-libs/gtk+-2.4
		 >=dev-libs/glib-2.6
		 >=gnome-base/libglade-2.5.1
		 >=gnome-base/nautilus-2.14
		 >=gnome-base/gconf-2.13.0
		 >=dev-libs/dbus-glib-0.71
		 bluetooth? ( >=net-wireless/gnome-bluetooth-0.6 )
		 eds? ( >=gnome-extra/evolution-data-server-1.5.3 )
		 gajim? ( net-im/gajim )
		 pidgin? ( >=net-im/pidgin-2.0.0 )
		 sylpheed?  (
						|| (
								mail-client/sylpheed
								mail-client/claws-mail
							)
					)
		 thunderbird? ( mail-client/mozilla-thunderbird )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=gnome-base/gnome-common-0.12
		>=dev-util/pkgconfig-0.19
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --disable-gaim
		$(use_enable bluetooth)
		$(use_enable eds evolution)
		$(use_enable pidgin)
		$(use_enable gajim)
		$(use_enable sylpheed)
		$(use_enable thunderbird)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Convert autodetection into hard options
	epatch "${FILESDIR}"/${PN}-0.14-configure-options.patch

	# Fix plugin versioning for pidgin plugin
	epatch "${FILESDIR}"/${PN}-0.12-pidgin-plugin-versioning.patch

	eautoreconf
	intltoolize --force || die "intltoolize force"
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use pidgin; then
		elog "To enable SendTo support in pidgin, you must enable the plugin in pidgin"
		elog "Check Tools -> Preferences -> Plugins in the pidgin menu."
	fi
}
