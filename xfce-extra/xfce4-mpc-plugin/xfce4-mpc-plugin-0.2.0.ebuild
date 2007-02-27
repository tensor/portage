# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""
DESCRIPTION="A simple xfce4 plugin for MPD"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-mpc-plugin"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
RESTRICT="mirror"

DEPEND=">=xfce-base/xfce4-4.3.90.0
	xfce-base/xfce4-dev-tools
	!xfce-extra/xfce4-mpc-plugin-live
	|| ( media-libs/libmpd media-libs/libmpd-live )"

src_install() {
	emake install DESTDIR=${D}
}
