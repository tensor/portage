# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-2.24.3.ebuild,v 1.7 2009/08/09 10:40:30 eva Exp $

inherit autotools eutils gnome2 python versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
SRC_URI="${SRC_URI} mirror://gentoo/${PN}-2.21.92-sessionsaver-v4.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 sparc ~x86"
IUSE="dbus examples pcre python xulrunner"

RDEPEND=">=www-client/epiphany-${MY_MAJORV}
	app-text/opensp
	>=dev-libs/glib-2.15.5
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.6
	>=x11-libs/gtk+-2.11.6
	>=gnome-base/libglade-2
	xulrunner? ( =net-libs/xulrunner-1.8* )
	!xulrunner? ( =www-client/mozilla-firefox-2* )
	dbus? ( >=dev-libs/dbus-glib-0.34 )
	pcre? ( >=dev-libs/libpcre-3.9-r2 )
	python? ( >=dev-python/pygtk-2.11 )"
DEPEND="${RDEPEND}
	  gnome-base/gnome-common
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.20
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	local extensions=""

	extensions="actions auto-reload auto-scroller certificates \
				error-viewer extensions-manager-ui gestures java-console \
				livehttpheaders page-info permissions push-scroller \
				select-stylesheet sessionsaver sidebar smart-bookmarks \
				tab-groups tab-states"

	use dbus && extensions="${extensions} rss"

	use pcre && extensions="${extensions} adblock greasemonkey"

	use python && extensions="${extensions} python-console favicon cc-license-viewer epilicious"
	use python && use examples && extensions="${extensions} sample-python"

	use examples && extensions="${extensions} sample sample-mozilla"

	G2CONF="${G2CONF} --with-extensions=$(echo "${extensions}" | sed -e 's/[[:space:]]\+/,/g')"

	if use xulrunner; then
		G2CONF="${G2CONF} --with-gecko=xulrunner"
	else
		G2CONF="${G2CONF} --with-gecko=firefox"

		if ! built_with_use =www-client/mozilla-firefox-2* filepicker; then
			ewarn "If you want the Certificate Management extension, please"
			ewarn "rebuild www-client/mozilla-firefox with USE='filepicker'"
		fi
	fi
}

src_unpack() {
	gnome2_src_unpack

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	# Don't remove sessionsaver, please.  -dang
	epatch "${WORKDIR}"/${PN}-2.21.92-sessionsaver-v4.patch
	echo "extensions/sessionsaver/ephy-sessionsaver-extension.c" >> po/POTFILES.in

	# Fix building with libtool-1  bug #257337
	rm m4/lt* m4/libtool.m4 m4/ltmain.m4

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use python; then
		python_mod_optimize /usr/$(get_libdir)/epiphany/${MY_MAJORV}/extensions
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm

	if use python; then
		python_mod_cleanup /usr/$(get_libdir)/epiphany/${MY_MAJORV}/extensions
	fi
}
