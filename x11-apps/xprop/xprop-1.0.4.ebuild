# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xprop/xprop-1.0.4.ebuild,v 1.9 2009/06/23 20:53:50 klausman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="property displayer for X"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}"
