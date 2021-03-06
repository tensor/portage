# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kglobalaccel/kglobalaccel-4.3.0.ebuild,v 1.2 2009/08/08 16:30:21 jer Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE's Global Shortcut Daemon"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug"

# Module renamed upstream
RDEPEND="
	!kdeprefix? ( !kde-base/kdedglobalaccel[-kdeprefix] )
	kdeprefix? ( !kde-base/kdedglobalaccel:${SLOT} )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_DESKTOP_FILE=NOTFOUND
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_PLUGIN=NOTFOUND"

	kde4-meta_src_configure
}
