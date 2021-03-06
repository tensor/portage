# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-mouse/xf86-input-mouse-1.2.2-r1.ebuild,v 1.6 2007/12/16 18:01:33 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="X.Org driver for mouse input devices"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ppc ppc64 ~sh sparc ~x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"

PATCHES="${FILESDIR}/${PV}-zaphod-xinerama-fix.diff"
