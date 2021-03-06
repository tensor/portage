# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.0.1-r1.ebuild,v 1.5 2007/12/26 07:54:47 drac Exp $

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.9"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local xsltlibs=$(pkg-config --libs libxslt libexslt)
	local xmllibs=$(pkg-config --libs libxml-2.0)

	LIBXSLT_LIBS="${xsltlibs}" LIBXML_LIBS="${xmllibs}" econf || die
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dosym /usr/bin/xml /usr/bin/xmlstarlet

	dodoc AUTHORS ChangeLog README TODO
	dohtml -r *
}

src_test() {
	cd tests
	sh runTests || die "sh runTests failed."
}
