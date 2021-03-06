# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mt19937/cl-mt19937-1.1.ebuild,v 1.2 2005/05/24 18:48:34 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Portable Mersenne Twister random number generator for Common Lisp"
HOMEPAGE="http://www.cliki.net/MT19937"
SRC_URI="mirror://gentoo/mt19937-${PV}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/mt19937-${PV}

CLPACKAGE=mt19937

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README
}
