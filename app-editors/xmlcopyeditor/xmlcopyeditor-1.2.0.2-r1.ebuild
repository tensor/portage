# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xmlcopyeditor/xmlcopyeditor-1.2.0.2-r1.ebuild,v 1.2 2008/10/24 21:13:39 pvdabeel Exp $

WX_GTK_VER="2.8"

inherit wxwidgets

DESCRIPTION="XML Copy Editor is a fast, free, validating XML editor"
HOMEPAGE="http://xml-copy-editor.sourceforge.net/"
SRC_URI="mirror://sourceforge/xml-copy-editor/${P}.tar.gz
		guidexml? ( mirror://gentoo/GuideXML-templates.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="guidexml"

DEPEND="dev-libs/libxml2  \
		dev-libs/libxslt  \
		dev-libs/xerces-c \
		dev-libs/boost    \
		dev-libs/libpcre  \
		app-text/aspell   \
		=x11-libs/wxGTK-2.8*"

pkg_setup() {
	check_wxuse X
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if use guidexml; then
		insinto /usr/share/xmlcopyeditor/templates/
		for TEMPLATE in "${WORKDIR}"/GuideXML-templates/*.xml; do
			newins "${TEMPLATE}" "${TEMPLATE##*/}" || die "GuideXML templates failed"
		done
	fi

	dodoc AUTHORS ChangeLog README NEWS
}
