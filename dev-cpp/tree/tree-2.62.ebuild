# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tree/tree-2.62.ebuild,v 1.3 2009/04/15 18:20:05 bicatali Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="An STL-like tree class"
HOMEPAGE="http://www.aei.mpg.de/~peekas/tree/"
SRC_URI="http://www.aei.mpg.de/~peekas/tree/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# test was buggy, reported upstream
	epatch "${FILESDIR}"/${P}-test.patch
}

src_test() {
	$(tc-getCXX) ${CXXFLAGS} test_tree.cc -o test_tree \
		|| die "compile test failed"
	./test_tree > mytest.output || die "running test failed"
	diff -Nu test_tree.output mytest.output || die "test dist failed"
}

src_install() {
	insinto /usr/include
	doins tree.hh tree_util.hh || die
	insinto /usr/share/doc/${PF}
	doins tree_example.cc || die
	if use doc; then
		doins tree.pdf || die
	fi
}
