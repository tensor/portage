# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-void/xf86-input-void-1.2.0.ebuild,v 1.10 2009/06/23 19:52:25 klausman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER="4"

inherit x-modular

DESCRIPTION="null input driver"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
