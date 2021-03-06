# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ctypes/ctypes-1.0.1-r1.ebuild,v 1.8 2007/10/28 02:19:40 fmccor Exp $

NEED_PYTHON=2.3

inherit distutils eutils

DESCRIPTION="Python module allowing to create and manipulate C data types."
HOMEPAGE="http://starship.python.net/crew/theller/ctypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-execstack.patch"
}

src_install() {
	DOCS="ACKS ANNOUNCE"
	distutils_src_install

	if use doc ; then
		insinto /usr/share/doc/${PF}/manual
		doins -r docs/manual/*
	fi
}

src_test() {
	PYTHONPATH="$(ls -d build/lib.*)" "${python}" setup.py test || die "tests failed"
}
