# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.3.0.ebuild,v 1.1 2009/08/04 01:27:45 wired Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	|| (
		>=dev-libs/soprano-2.3.0[clucene,dbus,raptor,redland]
		>=dev-libs/soprano-2.3.0[clucene,dbus,raptor,java]
	)
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop]
"
# BLOCKS:
# kde-base/akonadi: installed nepomuk ontologies, which were supposed to be here
RDEPEND="${DEPEND}
	!kdeprefix? ( !<kde-base/akonadi-4.2.60[-kdeprefix] )
	kdeprefix? ( !<kde-base/akonadi-4.2.60:${SLOT}[kdeprefix] )
"
