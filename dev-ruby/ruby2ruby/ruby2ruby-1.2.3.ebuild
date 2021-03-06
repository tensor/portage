# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby2ruby/ruby2ruby-1.2.3.ebuild,v 1.1 2009/08/07 06:50:13 graaff Exp $

inherit gems

DESCRIPTION="Generates readable ruby from ParseTree"
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="=dev-ruby/parsetree-3.0*
	=dev-ruby/sexp-processor-3.0*
	=dev-ruby/ruby_parser-2.0*"
RDEPEND="${DEPEND}"

USE_RUBY="ruby18"
