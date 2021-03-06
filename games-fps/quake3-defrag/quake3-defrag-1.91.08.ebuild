# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-defrag/quake3-defrag-1.91.08.ebuild,v 1.1 2006/03/31 01:49:28 wolf31o2 Exp $

MOD_DESC="Trickjumping challenges for Quake III"
MOD_NAME=defrag
inherit games games-q3mod

HOMEPAGE="http://www.planetquake.com/defrag/"
SRC_URI="http://cgg0.free.fr/defrag/defrag_${PV}.zip
	http://www.defrag-france.net/fichiers/defragpak1.zip
	http://www.defrag-france.net/fichiers/defragpak2.zip
	http://www.defrag-france.net/fichiers/defragpak3.zip
	http://www.defrag-france.net/fichiers/defragpak4.zip
	http://www.defrag-france.net/fichiers/defragpak5.zip
	http://www.defrag-france.net/fichiers/defragcpmpak01.zip
	http://www.german-defrag.de/files/defrag/defragpak7.zip
	http://www.german-defrag.de/files/defrag/defragpak8.zip
	http://www.defrag-france.net/fichiers/defragpak9.zip
	http://www.german-defrag.de/files/defrag/defragpak10.zip
	http://www.defrag-france.net/fichiers/defragpak11.zip
	http://www.german-defrag.de/files/defrag/df-extras002.zip"

LICENSE="freedist"

src_unpack() {
	unpack defrag_${PV}.zip
	cd defrag
	unpack defragpak{1,2,3,4,5,7,8,9,10,11}.zip
	unpack defragcpmpak01.zip
	unpack df-extras002.zip
	mv DeFRaG/* . && rm -r DeFRaG
	mv *.txt docs/
	# imo, the following is just cruft to be pruned
	rm defrag141.zip
	rm -rf misc/{mirc-script,misc,tools}
}
