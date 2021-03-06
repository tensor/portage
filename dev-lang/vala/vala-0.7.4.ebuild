# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.7.4.ebuild,v 1.2 2009/07/16 21:29:34 ssuominen Exp $

EAPI=1
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="+vapigen"
# test

RDEPEND=">=dev-libs/glib-2.12"
DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( sys-devel/bison dev-util/byacc dev-util/yacc )
	dev-util/pkgconfig
	dev-libs/libxslt"
#	test? ( dev-libs/dbus-glib )

# Needs a instance of dbus running wrt #275742.
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable vapigen)"
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
}
