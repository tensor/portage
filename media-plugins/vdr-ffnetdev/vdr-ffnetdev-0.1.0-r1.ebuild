# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ffnetdev/vdr-ffnetdev-0.1.0-r1.ebuild,v 1.1 2009/06/13 09:57:49 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: Output device which offers OSD via VNC and Video as raw mpeg over network"
HOMEPAGE="http://ffnetdev.berlios.de"
SRC_URI="mirror://berlios/${PN#vdr-}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}

DEPEND=">=media-video/vdr-1.3.7"
RDEPEND="${DEPEND}"

src_unpack() {
	vdr-plugin_src_unpack unpack

	epatch "${FILESDIR}/${P}-uint64.diff"
	epatch "${FILESDIR}/${P}-gcc4.3.patch"

	if grep -q "virtual cString Active" /usr/include/vdr/plugin.h; then
		epatch "${FILESDIR}/${P}-bigpatch-headers.diff"
	fi

	if has_version ">=media-video/vdr-1.6.0"; then
		epatch "${FILESDIR}/${P}-vdr-1.6.0.diff"
	fi

	vdr-plugin_src_unpack all_but_unpack
}
