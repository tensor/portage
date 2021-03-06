# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-rally/quake3-rally-1.2.ebuild,v 1.1 2006/10/26 14:02:28 wolf31o2 Exp $

MOD_DESC="total conversion car racing mod"
MOD_NAME="Rally"
MOD_DIR="q3rally"
MOD_BINS="rally"

inherit games games-mods

HOMEPAGE="http://www.quakerally.com"
SRC_URI="http://games.mirrors.tds.net/pub/planetquake3/modifications/quakeiiirally/q3rally_02March02.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/quakeiiirally/q3rally_26May02_update.zip"

LICENSE="as-is"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"
