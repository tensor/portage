# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egenix-mx-base/egenix-mx-base-3.0.0.ebuild,v 1.2 2007/08/17 15:12:00 uberlord Exp $

inherit distutils flag-o-matic

DESCRIPTION="egenix utils for Python"
HOMEPAGE="http://www.egenix.com/"
SRC_URI="http://www.egenix.com/files/python/${P}.tar.gz"

LICENSE="eGenixPublic-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="mx"

src_unpack() {
	distutils_src_unpack
	# doesn't play well with -fstack-protector (#63762)
	rm "mx/TextTools/Examples/pytag.py"

	# We do the optimization ourselves
	sed -i \
		-e 's/^\(optimize\) = 1/\1 = 0/' \
		setup.cfg || die "sed failed"

	# And we don't want the docs in site-packages
	sed -i \
		-e '/\/Doc\//d' \
		mxBASE.py || die "sed failed"
}

src_compile() {
	replace-flags "-O[3s]" "-O2"
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml -a html -r mx
	insinto /usr/share/doc/${PF}
	find "${S}" -iname "*.pdf" | xargs doins
}
