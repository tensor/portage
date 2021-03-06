# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-ur98/xf86-input-ur98-1.1.0.ebuild,v 1.7 2006/10/13 23:15:49 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="UR98 (TR88L803) head tracker driver"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
