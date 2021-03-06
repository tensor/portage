# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-2.3.3.ebuild,v 1.2 2009/07/26 06:43:49 graaff Exp $

inherit ruby gems
USE_RUBY="ruby18 ruby19"

DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.6
	=dev-ruby/activesupport-2.3.3
	=dev-ruby/rack-1.0*"
RDEPEND="${DEPEND}"
