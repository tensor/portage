# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/opengl/opengl-2.0.ebuild,v 1.1 2007/07/09 12:39:57 dcoutts Exp $

inherit ghc-package

DESCRIPTION="OpenGL bindings for Haskell"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=dev-lang/ghc-6.4*"

pkg_setup () {
	ghc-package_pkg_setup
	einfo "This library is already provided by ghc. This ebuild does nothing."
}

src_install () {
	dodir "$(ghc-libdir)"
	touch "${D}/$(ghc-libdir)/.${P}.ghc-updater"
}
