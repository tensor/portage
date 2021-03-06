# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnome2/ruby-gnome2-0.19.0.ebuild,v 1.1 2009/07/16 08:47:05 graaff Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby Gnome2 bindings"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
USE_RUBY="ruby18"

RDEPEND=">=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-gnomecanvas2-${PV}"
