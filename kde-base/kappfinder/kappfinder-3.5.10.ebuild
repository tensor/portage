# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kappfinder/kappfinder-3.5.10.ebuild,v 1.1 2008/09/13 23:57:24 carlo Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE tool looking for well-known apps in your path and creates entries for them in the KDE menu"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND=">=kde-base/kicker-${PV}:${SLOT}"