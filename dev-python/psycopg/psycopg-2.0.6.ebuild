# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-2.0.6.ebuild,v 1.2 2008/05/19 19:47:13 dev-zero Exp $

NEED_PYTHON=2.4

inherit eutils distutils

MY_P=${PN}2-${PV}

DESCRIPTION="PostgreSQL database adapter for Python."
SRC_URI="http://initd.org/pub/software/psycopg/${MY_P}.tar.gz"
HOMEPAGE="http://initd.org/projects/psycopg2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
LICENSE="GPL-2"
IUSE="debug doc examples mxdatetime"

DEPEND="virtual/postgresql-base
	mxdatetime? ( dev-python/egenix-mx-base )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PYTHON_MODNAME=${PN}2

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use debug; then
		sed -i 's/^\(define=\)/\1PSYCOPG_DEBUG,/' setup.cfg || die "sed failed"
	fi

	if use mxdatetime; then
		sed -i 's/\(use_pydatetime=\)1/\10/' setup.cfg || die "sed failed"
	fi

	# Fixes compilation issue in fbsd.
	epatch "${FILESDIR}/${P}-fbsd.patch"
}

src_install() {
	DOCS="AUTHORS doc/HACKING doc/SUCCESS doc/TODO doc/async.txt"
	distutils_src_install

	insinto /usr/share/doc/${PF}
	use examples && doins -r examples

	cd doc
	use doc && dohtml -r .
}
