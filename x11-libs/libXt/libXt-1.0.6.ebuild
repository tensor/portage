# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXt/libXt-1.0.6.ebuild,v 1.1 2009/08/06 10:49:07 remi Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xt library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	x11-proto/xproto
	x11-proto/kbproto"
DEPEND="${RDEPEND}"

PATCHES=("${FILESDIR}/libXt-1.0.6-cross.patch")

pkg_setup() {
	# No such function yet
	# x-modular_pkg_setup

	# (#125465) Broken with Bdirect support
	filter-flags -Wl,-Bdirect
	filter-ldflags -Bdirect
	filter-ldflags -Wl,-Bdirect
}
