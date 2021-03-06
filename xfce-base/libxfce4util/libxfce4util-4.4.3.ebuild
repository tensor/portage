# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.4.3.ebuild,v 1.8 2009/05/21 19:53:00 angelos Exp $

EAPI=1

inherit xfce44

XFCE_VERSION=4.4.3

xfce44
xfce44_core_package

DESCRIPTION="Basic utilities library"
HOMEPAGE="http://www.xfce.org/projects/libraries"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
LICENSE="LGPL-2"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2.6:2"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
