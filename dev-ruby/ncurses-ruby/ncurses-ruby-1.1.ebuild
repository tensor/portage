# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ncurses-ruby/ncurses-ruby-1.1.ebuild,v 1.10 2009/07/14 18:22:01 graaff Exp $

inherit ruby

DESCRIPTION="Ruby wrappers of ncurses and PDCurses libs"
HOMEPAGE="http://ncurses-ruby.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="examples"
DEPEND=">=sys-libs/ncurses-5.3"
