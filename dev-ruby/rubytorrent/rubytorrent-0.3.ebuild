# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubytorrent/rubytorrent-0.3.ebuild,v 1.9 2007/08/07 03:00:13 vapier Exp $

inherit ruby

DESCRIPTION="A pure-Ruby BitTorrent peer library and toolset"
HOMEPAGE="http://rubytorrent.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/3017/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc x86"
IUSE=""

DEPEND="virtual/ruby"

USE_RUBY="ruby18 ruby19"

src_install() {
	local sitelibdir=`${RUBY} -r rbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	insinto "$sitelibdir"
	doins rubytorrent.rb || die
	insinto "$sitelibdir/rubytorrent"
	doins rubytorrent/* || die
	dodoc doc/* README ReleaseNotes.txt
	docinto examples
	dodoc dump-metainfo.rb dump-peers.rb make-metainfo.rb \
		rtpeer-ncurses.rb rtpeer.rb
}

pkg_postinst() {
	elog "Examples on how to use this package can be found at /usr/share/doc/${PF}/examples/"
}
