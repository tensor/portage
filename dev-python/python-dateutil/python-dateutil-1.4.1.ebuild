# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dateutil/python-dateutil-1.4.1.ebuild,v 1.1 2009/01/14 17:39:15 bicatali Exp $

EAPI=2
NEED_PYTHON=2.3
inherit eutils distutils

DESCRIPTION="dateutil datetime math and logic library for python"
HOMEPAGE="http://labix.org/python-dateutil"
SRC_URI="http://labix.org/download/python-dateutil/${P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DOCS="NEWS README"

DEPENDS="sys-libs/timezone-data"
PYTHON_MODNAME=dateutil

src_prepare() {
	epatch "${FILESDIR}"/${P}-locale.patch
	# use zoneinfo in /usr/share/zoneinfo
	sed -i -e 's/zoneinfo.gettz/gettz/g' test.py || die
}

src_test() {
	PYTHONPATH=build/lib "${python}" test.py || die
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins example.py sandbox/*.py
	rm -f "${D}"/usr/lib*/python*/site-packages/dateutil/zoneinfo/*.tar.*
}
