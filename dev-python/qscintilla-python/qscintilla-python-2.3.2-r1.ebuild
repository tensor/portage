# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla-python/qscintilla-python-2.3.2-r1.ebuild,v 1.4 2009/06/17 13:12:16 fauli Exp $

EAPI="2"

inherit eutils python

MY_PN="qscintilla"
MY_P="${MY_PN/qs/QS}-gpl-${PV}"

DESCRIPTION="Python bindings for Qscintilla"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/QScintilla2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="qt4"

DEPEND=">=dev-python/sip-4.4
	=x11-libs/qscintilla-${PV}*[qt4=]
	qt4? ( >=dev-python/PyQt4-4.4 )
	!qt4? ( >=dev-python/PyQt-3.17.6  )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/Python

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2-nostrip.patch
}

src_configure() {
	local myconf="-o /usr/lib -n /usr/include"
	if use qt4; then
		myconf="${myconf} -p 4"
	else
		myconf="${myconf} -p 3"
	fi

	python_version
	${python} configure.py ${myconf} || die "configure.py failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
}
