# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="A flashcard program that implements Leitner cardfile methodology"
HOMEPAGE="http://granule.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-7.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.4.1
	>=dev-cpp/libassa-3.5.0
	x11-libs/gtk+
	dev-cpp/glibmm
	>=dev-libs/libsigc++-2.0
	x11-libs/pango
	dev-libs/glib
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

S="${WORKDIR}/${P}-7"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
