# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.2.0.ebuild,v 1.14 2008/07/10 15:20:06 remi Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="-amd64 ~hppa ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libglade-2
	=dev-cpp/gtkmm-2.2*"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

# Needed for 2.0.0, it misses some make/libtool magic
# export SED=sed

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gcc34.patch
	epatch "${FILESDIR}"/${P}-configure.patch
}
