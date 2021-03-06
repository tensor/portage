# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coderay/coderay-0.8.312.ebuild,v 1.1 2009/06/27 11:09:08 graaff Exp $

inherit ruby gems

DESCRIPTION="A Ruby library for syntax highlighting."
HOMEPAGE="http://coderay.rubychan.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.2"
RDEPEND="${DEPEND}"
