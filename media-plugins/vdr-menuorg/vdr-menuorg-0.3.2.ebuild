# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-menuorg/vdr-menuorg-0.3.2.ebuild,v 1.2 2008/06/20 12:50:55 zzam Exp $

EAPI="1"

inherit vdr-plugin

DESCRIPTION="VDR plugin: make osd menu configurable via config-file"
HOMEPAGE="http://www.e-tobi.net/blog/pages/vdr-menuorg/"
SRC_URI="http://www.e-tobi.net/blog/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.47
	dev-cpp/libxmlpp:2.6
	dev-cpp/glibmm"

pkg_setup() {
	if [[ ! -f /usr/include/vdr/menuorgpatch.h ]]; then
		eerror "please compile VDR with USE=\"menuorg\""
		die "can not compile packet without menuorg-support from vdr"
	fi
	vdr-plugin_pkg_setup
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/menuorg
	doins menuorg.xml
}
