# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-4.3.0.ebuild,v 1.1 2009/08/04 00:07:49 wired Exp $

EAPI="2"

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	!kdeprefix? ( !<kde-base/kde-wallpapers-${PV}[-kdeprefix] )
	kdeprefix? ( !<kde-base/kde-wallpapers-${PV}:${SLOT} )
"
