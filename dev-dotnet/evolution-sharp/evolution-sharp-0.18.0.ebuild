# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/evolution-sharp/evolution-sharp-0.18.0.ebuild,v 1.2 2008/11/01 13:35:47 dsd Exp $

inherit mono gnome.org

DESCRIPTION="Mono bindings for Evolution"
HOMEPAGE="http://www.gnome.org/projects/beagle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-extra/evolution-data-server-1.8.1-r1
	>=dev-dotnet/gtk-sharp-2.4
	dev-lang/mono"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Use correct libdir in pkgconfig files
	sed -i -e 's:^libdir.*:libdir=@libdir@:' \
		-e 's:^prefix=:exec_prefix=:' \
		-e 's:prefix)/lib:libdir):' \
		"${S}"/*.pc.in || die "sed failed."

	# r188 broke TestCal compilation
	sed -i -e 's/TEST_TARGETS = $(TESTCAL_TARGET)/TEST_TARGETS = /g' \
		"${S}"/evolution/Makefile.in || die "sed TestCal failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README
}