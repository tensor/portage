# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-2.2.9-r1.ebuild,v 1.6 2009/08/02 15:30:08 maekke Exp $

EAPI=2

inherit eutils gnome2

DOC_VER="2.2.0"

DESCRIPTION="A personal finance manager"
HOMEPAGE="http://www.gnucash.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.lzma"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"

IUSE="+doc ofx hbci chipcard debug quotes"

# FIXME: rdepend on dev-libs/qof when upstream fix their mess (see configure.in)

RDEPEND=">=dev-libs/glib-2.6.3
	>=dev-scheme/guile-1.8.3[deprecated,regex]
	dev-scheme/guile-www
	>=dev-scheme/slib-3.1.4
	>=sys-libs/zlib-1.1.4
	>=dev-libs/popt-1.5
	>=x11-libs/gtk+-2.10
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libglade-2.4
	>=gnome-extra/gtkhtml-3.14
	>=dev-libs/libxml2-2.5.10
	>=gnome-base/gconf-2
	>=x11-libs/goffice-0.6[gnome]
	ofx? ( >=dev-libs/libofx-0.7.0 )
	hbci? ( net-libs/aqbanking[qt3]
		chipcard? ( sys-libs/libchipcard )
	)
	quotes? ( dev-perl/DateManip
		>=dev-perl/Finance-Quote-1.11
		dev-perl/HTML-TableExtract )
	media-libs/libart_lgpl
	x11-libs/pango"

DEPEND="${RDEPEND}
	app-arch/lzma-utils
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/libtool
	>=app-text/scrollkeeper-0.3"

PDEPEND="doc? ( >=app-doc/gnucash-docs-${DOC_VER} )"
ELTCONF="--patch-only"
DOCS="doc/README.OFX doc/README.HBCI"

# FIXME: no the best thing to do but it'd be even better to fix autofoo
MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable ofx)
		$(use_enable hbci aqbanking)
		--disable-doxygen
		--enable-locale-specific-tax
		--disable-error-on-warning"
}

src_prepare() {
	epatch "${FILESDIR}"/r18166-to-r18167.diff
	gnome2_src_prepare
}

src_test() {
	GUILE_WARN_DEPRECATED=no \
	GNC_DOT_DIR="${T}"/.gnucash \
	emake check \
	|| die "Make check failed. See above for details."
}

src_install() {
	gnome2_src_install GNC_DOC_INSTALL_DIR=/usr/share/doc/${PF}

	rm -rf "${D}"/usr/share/doc/${PF}/{examples/,COPYING,INSTALL,*win32-bin.txt,projects.html}
#	prepalldocs
	mv "${D}"/usr/share/doc/${PF} "${T}"/cantuseprepalldocs || die
	dodoc "${T}"/cantuseprepalldocs/* || die
}
