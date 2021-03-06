# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xtrap/xtrap-1.0.2.ebuild,v 1.6 2009/05/05 08:17:10 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xtrap application"
KEYWORDS="amd64 arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXTrap"
DEPEND="${RDEPEND}
	x11-proto/trapproto"
