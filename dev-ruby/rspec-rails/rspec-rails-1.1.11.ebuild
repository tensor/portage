# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec-rails/rspec-rails-1.1.11.ebuild,v 1.5 2008/12/14 14:03:42 nixnut Exp $

inherit gems

DESCRIPTION="RSpec's official Ruby on Rails plugin"
HOMEPAGE="http://rspec.info/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="=dev-ruby/rspec-1.1.11
	>=dev-ruby/hoe-1.8.1"
