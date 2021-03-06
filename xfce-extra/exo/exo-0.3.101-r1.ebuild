# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.101-r1.ebuild,v 1.7 2009/07/27 17:32:38 nixnut Exp $

EAPI="1"

inherit xfce4 python

XFCE_VERSION=4.6.1

xfce4_core

DESCRIPTION="Extensions, widgets and framework library with session management support"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug doc hal libnotify python"

RDEPEND=">=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	libnotify? ( x11-libs/libnotify )
	hal? ( sys-apps/hal )
	python? ( dev-python/pygtk )"
DEPEND="${RDEPEND}
	dev-util/intltool
	doc? ( dev-util/gtk-doc )"

XFCE4_PATCHES="${FILESDIR}/exo-0.3.101-iocharset.patch"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable doc gtk-doc) $(use_enable hal)
	$(use_enable libnotify notifications) $(use_enable python)"
}

src_unpack() {
	xfce4_src_unpack
	cd "${S}"
	rm py-compile
	touch py-compile
	chmod +x py-compile
}

pkg_postinst() {
	xfce4_pkg_postinst
	python_mod_optimize /usr/lib*/python*/site-packages
}

pkg_postrm() {
	xfce4_pkg_postrm
	python_mod_cleanup /usr/lib*/python*/site-packages
}

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
