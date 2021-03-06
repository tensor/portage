# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymetar/pymetar-0.13.ebuild,v 1.3 2008/05/14 13:33:41 armin76 Exp $

NEED_PYTHON="2.3"

inherit distutils

DESCRIPTION="Downloads the weather report for a given station ID, decodes it and the provides easy access to all the data found in the report."
HOMEPAGE="http://www.schwarzvogel.de/software-pymetar.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="librarydoc.txt THANKS bin/example.py"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Faulty setup.py installs ez_setup.py generated by distutils_src_unpack
	sed -i \
		-e '/packages/d' \
		-e "s|'COPYING', ||" \
		setup.py || die "sed failed"

	distutils_src_unpack
}
