# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/efont-unicode/efont-unicode-0.4.2-r1.ebuild,v 1.12 2007/09/16 03:28:25 dirtyepic Exp $

inherit font font-ebdftopcf

IUSE=""

MY_P="${PN}-bdf-${PV}"

DESCRIPTION="The /efont/ Unicode Bitmap Fonts"
HOMEPAGE="http://openlab.jp/efont/unicode/"
SRC_URI="http://openlab.jp/efont/dist/unicode-bdf/${MY_P}.tar.bz2"

# naga10 has free-noncomm license
LICENSE="public-domain BAEKMUK X11 as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

S="${WORKDIR}/${MY_P}"
FONT_S=${S}
DOCS="README* COPYRIGHT ChangeLog INSTALL"

# Only installs fonts
RESTRICT="strip binchecks"
