# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-last-fm/gmpc-last-fm-0.18.0.ebuild,v 1.5 2009/06/09 19:05:42 fauli Exp $

EAPI=2

DESCRIPTION="This plugin fetches artist art from last.fm"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Last.fm"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	x11-libs/gtk+:2[jpeg]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
