# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-ssh-gateway/net-ssh-gateway-1.0.1.ebuild,v 1.4 2009/04/10 14:41:23 armin76 Exp $

inherit gems

DESCRIPTION="A simple library to assist in enabling tunneled Net::SSH connections"
HOMEPAGE="http://net-ssh.rubyforge.org/gateway"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ia64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=dev-ruby/net-ssh-2.0.0"
