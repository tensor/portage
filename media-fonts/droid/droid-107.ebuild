# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/droid/droid-107.ebuild,v 1.4 2009/05/12 08:41:16 loki_val Exp $

inherit font

# $PV is a build number, use fontforge to find it out
# 107 was repackaged from Android 0.9 SDK Beta (r1)
DESCRIPTION="Font family from Google's Android project"
HOMEPAGE="http://code.google.com/android/RELEASENOTES.html"
SRC_URI="http://omploader.org/vcGMx/DroidFamily-${PV}.zip"
LICENSE="Apache-2.0"
RESTRICT="mirror" # redistributed without license
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"

RDEPEND=""
DEPEND="app-arch/unzip"
