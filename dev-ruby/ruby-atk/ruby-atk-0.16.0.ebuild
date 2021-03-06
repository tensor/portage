# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-atk/ruby-atk-0.16.0.ebuild,v 1.7 2007/05/21 11:24:10 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Atk bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="dev-libs/atk"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
