# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-4.3.1.ebuild,v 1.6 2009/05/16 18:58:28 nixnut Exp $

EAPI="2"

NEED_PYTHON=2.4

inherit python eutils

MY_PN=${PN}4
MY_P=${MY_PN}-${PV}
DESCRIPTION="A full featured Python IDE that is written in PyQt4 using the QScintilla editor widget"
HOMEPAGE="http://www.die-offenbachs.de/eric/index.html"
SRC_URI="mirror://sourceforge/eric-ide/${MY_P}.tar.gz
	linguas_cs? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-cs-${PV}.tar.gz )
	linguas_de? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-de-${PV}.tar.gz )
	linguas_es? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-es-${PV}.tar.gz )
	linguas_fr? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-fr-${PV}.tar.gz )
	linguas_ru? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-ru-${PV}.tar.gz )
	linguas_tr? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-tr-${PV}.tar.gz )"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE="linguas_cs linguas_de linguas_es linguas_fr linguas_ru linguas_tr"

DEPEND="dev-python/PyQt4[svg]
	>=dev-python/qscintilla-python-2.2[qt4]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

LANGS="cs de es fr ru tr"

python_version

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch "${FILESDIR}"/4.3.0-paths.patch
	epatch "${FILESDIR}"/4.2.3-no-interactive.patch
}

src_install() {
	# Change qt dir to be located in ${D}
	dodir /usr/share/qt4/
	${python} install.py \
		-z \
		-b "/usr/bin" \
		-i "${D}" \
		-d "/usr/$(get_libdir)/python${PYVER}/site-packages" \
		-c || die "python install.py failed"

	make_desktop_entry "eric4 --nosplash" \
			eric4 \
			"/usr/$(get_libdir)/python${PYVER}/site-packages/eric4/icons/default/eric.png" \
			"Development;IDE;Qt"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/eric4{,plugins}
	elog "If you want to use eric4 with mod_python, have a look at"
	elog "\"${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/eric4/patch_modpython.py\"."
	elog
	elog "The following packages will give eric extended functionality."
	elog
	elog "dev-python/pylint"
	elog "dev-python/pysvn            (in sunrise overlay atm)"
	elog
	elog "This version has a new plugin interface with plugin-autofetch from"
	elog "the App itself. You may want to check those as well"
}

pkg_postrm() {
	python_mod_cleanup
}
