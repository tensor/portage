# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.6.0.ebuild,v 1.10 2009/08/08 23:38:11 ssuominen Exp $

EAPI=1

MY_PN="gtk-xfce-engine"
inherit xfce4

XFCE_VERSION=4.6.0

xfce4_core

DESCRIPTION="GTK+ Xfce4 theme engine"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=dev-libs/glib-2.6:2
	x11-libs/cairo
	x11-libs/pango"

DOCS="AUTHORS ChangeLog NEWS README"
