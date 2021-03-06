# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.6.17.ebuild,v 1.2 2009/06/08 11:26:22 jer Exp $

EAPI=2
NEED_PYTHON=2.5
inherit distutils python

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

src_install() {
	dohtml *.html && rm -f *.html
	distutils_src_install
	dobin bin/eyeD3 || die "dobin failed"
	doman doc/*.1
}
