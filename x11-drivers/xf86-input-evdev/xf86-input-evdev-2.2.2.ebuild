# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.2.2.ebuild,v 1.2 2009/06/23 19:53:35 klausman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Generic Linux input driver"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.5.3"
DEPEND="${RDEPEND}
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	>=x11-proto/inputproto-1.4
	x11-proto/xproto"
