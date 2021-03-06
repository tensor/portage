# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-0.12.ebuild,v 1.4 2009/06/09 16:28:52 scarabeus Exp $

EAPI=2
inherit cmake-utils eutils multilib python

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://matt.colyer.name/projects/iphone-linux/index.php?title=Main_Page"
SRC_URI="http://cloud.github.com/downloads/JonathanBeck/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-lang/swig"

src_prepare() {
	sed -e 's:-Werror::g' \
		-i swig/CMakeLists.txt || die "sed failed"
}

src_configure() {
	python_version
	mycmakeargs="-DCMAKE_SKIP_RPATH=ON
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)
		-DPYTHON_VERSION=${PYVER}
	"
	cmake-utils_src_configure
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	python_mod_cleanup
}
