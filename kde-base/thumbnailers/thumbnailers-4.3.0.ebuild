# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/thumbnailers/thumbnailers-4.3.0.ebuild,v 1.2 2009/08/08 16:31:31 jer Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug"

KMEXTRACTONLY="
	libs/mobipocket
"

DEPEND="
	>=kde-base/libkdcraw-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkexiv2-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !<kde-base/kdegraphics-strigi-analyzer-4.2.91[-kdeprefix] )
	kdeprefix? ( !<kde-base/kdegraphics-strigi-analyzer-4.2.91:${SLOT}[kdeprefix] )
"
