# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-4.3.0.ebuild,v 1.1 2009/08/03 23:59:13 wired Exp $

EAPI="2"

KMNAME="kdeutils"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE calculator"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	dev-libs/gmp
"
RDEPEND="${DEPEND}"
