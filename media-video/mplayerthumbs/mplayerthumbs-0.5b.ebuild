# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-0.5b.ebuild,v 1.4 2009/02/10 11:05:30 tampakrap Exp $

inherit kde

DESCRIPTION="A Thumbnail Generator for Video Files on Konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=41180"
SRC_URI="http://xoomer.alice.it/rockman81/${P}.tar.bz2"
LICENSE="GPL-2"

RESTRICT=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="( || ( =kde-base/konqueror-3.5* =kde-base/kdebase-3.5* ) )
		( || ( media-video/mplayer media-video/mplayer-bin ) )"
RDEPEND="${DEPEND}"

need-kde 3.3

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )
