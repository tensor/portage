# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-power-manager/gnome-power-manager-2.24.4-r2.ebuild,v 1.1 2009/05/02 18:26:31 dang Exp $

inherit autotools eutils gnome2 virtualx

DESCRIPTION="Gnome Power Manager"
HOMEPAGE="http://www.gnome.org/projects/gnome-power-manager/"
SRC_URI="${SRC_URI} mirror://gentoo/${P}-cpufreq-patches.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc policykit test"

# See bug #196490
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.6.0
	>=x11-libs/gtk+-2.11.0
	>=gnome-base/gnome-keyring-0.6.0
	>=gnome-base/libgnome-2.14.0
	>=gnome-base/libgnomeui-2.14.0
	>=sys-apps/hal-0.5.9
	>=dev-libs/dbus-glib-0.71
	>=gnome-base/libglade-2.5.0
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/libwnck-2.10.0
	>=x11-libs/cairo-1.0.0
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-2
	=media-libs/gstreamer-0.10*
	policykit? (
		>=sys-auth/policykit-0.8
		>=sys-apps/hal-0.5.12_rc1-r2
		>=gnome-extra/policykit-gnome-0.8 )

	>=x11-apps/xrandr-1.2

	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	sys-devel/gettext
	~app-text/docbook-xml-dtd-4.3
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	doc? (
		app-text/xmlto
		app-text/docbook-sgml-utils
		~app-text/docbook-xml-dtd-4.4
		~app-text/docbook-sgml-dtd-4.1
		~app-text/docbook-xml-dtd-4.1.2 )"
# docbook-sgml-utils and docbook-sgml-dtd-4.1 used for creating man pages
# (files under ${S}/man).
# docbook-xml-dtd-4.4 and -4.1.2 are used by the xml files under ${S}/docs.

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable test tests)
		$(use_enable doc docbook-docs)
		$(use_enable policykit)
		$(use_enable policykit gconf-defaults)
		--with-dpms-ext
		--enable-xevents
		--enable-applets"
}

src_unpack() {
	gnome2_src_unpack

	if ! use doc; then
		# Remove the docbook2man rules here since it's not handled by a proper
		# parameter in configure.in.
		sed -e 's:@HAVE_DOCBOOK2MAN_TRUE@.*::' -i "${S}/man/Makefile.in" || die "sed 1 failed"
	fi

	# Fix cpufreq-regression bug #247614
	epatch "${WORKDIR}/${P}-cpufreq-libhal-glib.patch"
	epatch "${WORKDIR}/${P}-cpufreq-support.patch"
	epatch "${WORKDIR}/${P}-cpufreq-ui.patch"

	# Remove stupid gcc flags, bug #265317
	sed "s:-Werror::g" -i configure.ac || die "sed 3 failed"

	# Make it libtool-1 compatible
	rm -v m4/lt* m4/libtool.m4 || die "removing libtool macros failed"
	eautoreconf

	# glibc splits this out, whereas other libc's do not tend to
	use elibc_glibc || sed -e 's/-lresolv//' -i configure || die "sed 2 failed"
}

src_test() {
	Xemake check || die "Test phase failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog
	elog "To enable frequency scaling interface, use the following command:"
	elog "	gconftool-2 /apps/gnome-power-manager/ui/cpufreq_show"
	elog "Note that this will conflict with other power managment utility"
	elog "like app-laptop/laptop-mode-tools."
	elog
}
