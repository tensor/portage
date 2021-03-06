# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.23.0.ebuild,v 1.5 2009/07/18 13:23:57 ssuominen Exp $

EAPI=2

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://gpsim.sourceforge.net"
SRC_URI="mirror://sourceforge/gpsim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE="doc gtk"

RDEPEND="dev-libs/glib
	dev-libs/popt
	>=dev-embedded/gputils-0.12.0
	gtk? ( >=x11-libs/gtk+extra-2.1.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	|| ( dev-util/yacc sys-devel/bison )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable gtk gui)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ANNOUNCE AUTHORS ChangeLog HISTORY NEWS \
		PROCESSORS README README.MODULES TODO

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${S}"/doc/gpsim.pdf
	fi
}
