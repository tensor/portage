# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wmdock/xfce4-wmdock-0.3.2.ebuild,v 1.2 2009/02/14 16:48:12 angelos Exp $

inherit xfce44

xfce44_goodies_panel_plugin

DESCRIPTION="a compatibility layer for running WindowMaker dockapps on Xfce4."
HOMEPAGE="http://www.ibh.de/~ellguth/xfce4-wmdock-plugin.html"

KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo panel-plugin/wmdock.desktop.in.in >>po/POTFILES.skip
}

DOCS="AUTHORS ChangeLog README TODO"
