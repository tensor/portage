# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gvfs/gvfs-1.0.2.ebuild,v 1.1 2008/10/23 20:29:21 eva Exp $

inherit bash-completion gnome2 eutils

DESCRIPTION="GNOME Virtual Filesystem Layer"
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="archive avahi bluetooth cdda doc fuse gnome gphoto2 hal gnome-keyring samba"

RDEPEND=">=dev-libs/glib-2.17.6
		 >=sys-apps/dbus-1.0
		 >=net-libs/libsoup-2.23.91
		 dev-libs/libxml2
		 net-misc/openssh
		 archive? ( app-arch/libarchive )
		 avahi? ( >=net-dns/avahi-0.6 )
		 cdda?  (
					>=sys-apps/hal-0.5.10
					>=dev-libs/libcdio-0.78.2
				)
		 fuse? ( sys-fs/fuse )
		 gnome? ( >=gnome-base/gconf-2.0 )
		 hal? ( >=sys-apps/hal-0.5.10 )
		 bluetooth? (
			dev-libs/dbus-glib
			>=net-wireless/bluez-libs-3.12
			dev-libs/expat
			)
		 gphoto2? ( >=media-libs/libgphoto2-2.4 )
		 gnome-keyring? ( >=gnome-base/gnome-keyring-1.0 )
		 samba? ( >=net-fs/samba-3 )"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.40
		>=dev-util/pkgconfig-0.19
		doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
			--enable-http
			--disable-bash-completion
			$(use_enable archive)
			$(use_enable avahi)
			$(use_enable bluetooth obexftp)
			$(use_enable cdda)
			$(use_enable fuse)
			$(use_enable gnome gconf)
			$(use_enable gphoto2)
			$(use_enable hal)
			$(use_enable gnome-keyring keyring)
			$(use_enable samba)"

	if use cdda && built_with_use dev-libs/libcdio minimal; then
		ewarn
		ewarn "CDDA support in gvfs requires dev-libs/libcdio to be built"
		ewarn "without the minimal USE flag."
		die "Please re-emerge dev-libs/libcdio without the minimal USE flag"
	fi
}

src_install() {
	gnome2_src_install
	use bash-completion && \
		dobashcompletion programs/gvfs-bash-completion.sh ${PN}
}

pkg_postinst() {
	gnome2_pkg_postinst
	use bash-completion && bash-completion_pkg_postinst
}
