# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xhtml1/xhtml1-20020801-r4.ebuild,v 1.4 2008/01/19 15:16:46 grobian Exp $

inherit sgml-catalog eutils

DESCRIPTION="DTDs for the eXtensible HyperText Markup Language 1.0"
HOMEPAGE="http://www.w3.org/TR/xhtml1/"
SRC_URI="http://www.w3.org/TR/xhtml1/xhtml1.tgz"
LICENSE="W3C"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-text/sgml-common
	dev-libs/libxml2"
RDEPEND=""

sgml-catalog_cat_include "/etc/sgml/${PN}.cat" \
	"/usr/share/sgml/${PN}/xhtml.soc"

xml_catalog_setup() {
	CATALOG="${ROOT}etc/xml/catalog"
	XMLTOOL="${ROOT}usr/bin/xmlcatalog"
	DTDDIR="${ROOT}usr/share/sgml/${PN}"

	[ -x "${XMLTOOL}" ] || return 1

	return 0
}

src_unpack() {
	unpack ${A}
	cd "${S}"/DTD

	epatch "${FILESDIR}"/${PN}-catalog.patch
}

src_install() {
	insinto /usr/share/sgml/${PN}
	doins DTD/xhtml.soc DTD/*.dcl DTD/*.dtd DTD/*.ent
	insinto /etc/sgml
	dodoc *.pdf *.ps
	dohtml *.html *.png *.css
}

pkg_postinst() {
	sgml-catalog_pkg_postinst
	xml_catalog_setup || return

	einfo "Installing xhtml1 in the global XML catalog"

	$XMLTOOL --noout --add 'public' '-//W3C//DTD XHTML 1.0 Strict//EN' \
		${DTDDIR}/xhtml1-strict.dtd $CATALOG
	$XMLTOOL --noout --add 'public' '-//W3C//DTD XHTML 1.0 Transitional//EN' \
		${DTDDIR}/xhtml1-transitional.dtd $CATALOG
	$XMLTOOL --noout --add 'public' '-//W3C//DTD XHTML 1.0 Frameset//EN' \
		${DTDDIR}/xhtml1-frameset.dtd $CATALOG
	$XMLTOOL --noout --add 'rewriteSystem' 'http://www.w3.org/TR/xhtml1/DTD' \
		${DTDDIR} $CATALOG
	$XMLTOOL --noout --add 'rewriteURI' 'http://www.w3.org/TR/xhtml1/DTD' \
		${DTDDIR} $CATALOG
}

pkg_postrm() {
	sgml-catalog_pkg_postrm
	xml_catalog_setup || return

	if [ -d "$DTDDIR" ]; then
		einfo "The xhtml1 data directory still exists."
		einfo "No entries will be removed from the XML catalog."
		return
	fi

	einfo "Removing xhtml1 from the global XML catalog"

	$XMLTOOL --noout --del '-//W3C//DTD XHTML 1.0 Strict//EN' $CATALOG
	$XMLTOOL --noout --del '-//W3C//DTD XHTML 1.0 Transitional//EN' $CATALOG
	$XMLTOOL --noout --del '-//W3C//DTD XHTML 1.0 Frameset//EN' $CATALOG
	$XMLTOOL --noout --del 'http://www.w3.org/TR/xhtml1/DTD' $CATALOG
}
