# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-base/kaa-base-0.1.3.ebuild,v 1.5 2007/10/06 20:13:26 dertobi123 Exp $

inherit python eutils distutils

DESCRIPTION="Basic Framework for all Kaa Python Modules."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="sqlite lirc"

RDEPEND="dev-libs/libxml2
	sqlite? ( >=dev-libs/glib-2.4.0 >=dev-python/pysqlite-2.2 )
	lirc? ( dev-python/pylirc )
	dev-python/pygobject"

pkg_setup() {
	if !(built_with_use dev-libs/libxml2 python); then
		eerror "dev-libs/libxml2 must be built with the 'python' USE flag"
		die "Recompile dev-libs/libxml2 with the 'python' USE flag enabled"
	fi
}
