# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/quickplot/quickplot-0.8.13-r1.ebuild,v 1.4 2008/08/30 14:21:02 ranger Exp $

inherit eutils

DESCRIPTION="A fast interactive 2D plotter."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://quickplot.sourceforge.net/"

IUSE="sndfile"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

RDEPEND=">=dev-cpp/gtkmm-2.4.5
	sndfile? ( media-libs/libsndfile )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-libsigc++-2.2.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-linking.patch

	# Some files have been moved around to more appropriate locations
	sed -i \
		-e 's|quickplot_icon.png|/usr/share/pixmaps/quickplot.png|' \
		-e  's|href="ChangeLog"|href="../ChangeLog.gz"|' \
		index.html.in
	sed -i -e 's|href="COPYING"|href="/usr/portage/licenses/GPL-2"|' \
		about.html.in
}

src_compile() {
	econf $(use_with sndfile libsndfile) || die "econf step failed."
	emake htmldir=/usr/share/doc/${PF}/html || die "emake step failed."
}

src_install () {
	emake \
		DESTDIR="${D}" \
		htmldir=/usr/share/doc/${PF}/html \
		install || die "make install step failed."
	dodoc AUTHORS ChangeLog README README.devel TODO
	# Remove COPYING as it is specified in LICENCE. Move other stuff.
	cd "${D}"/usr/share/doc/${PF}/html
	rm COPYING quickplot_icon.png ChangeLog
	mv "${D}"/usr/share/pixmaps/quickplot_icon.png \
		"${D}"/usr/share/pixmaps/quickplot.png
	make_desktop_entry 'quickplot --no-pipe' Quickplot quickplot Graphics
	mv "${D}"/usr/share/applications/quickplot\ --no-pipe.desktop \
		"${D}"/usr/share/applications/quickplot.desktop
}
