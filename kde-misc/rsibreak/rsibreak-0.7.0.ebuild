# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.7.0.ebuild,v 1.6 2007/07/22 10:38:08 philantrop Exp $

USE_KEG_PACKAGING="yes"

LANGS="bg br ca cs da de el en_GB es fr ga gl it ka nl pl pt sr sr@Latn sv tr"

inherit kde

MY_P="${PN/rsi/Rsi}-${PV/_rc/-rc}"

DESCRIPTION="A small utility which bothers you at certain intervals"
SRC_URI="http://www.rsibreak.org/images/e/e8/${MY_P}.tar.bz2"
HOMEPAGE="http://www.rsibreak.org/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

S="${WORKDIR}/${PN}-${PV/_rc/-rc}"

RDEPEND="x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
		x11-proto/scrnsaverproto"

need-kde 3.3

PATCHES="${FILESDIR}/${P}-crash.patch"
