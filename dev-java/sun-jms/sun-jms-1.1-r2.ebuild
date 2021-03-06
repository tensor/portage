# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jms/sun-jms-1.1-r2.ebuild,v 1.12 2008/06/16 19:18:02 serkan Exp $

inherit java-pkg-2

DOWNLOAD_PAGE="https://cds.sun.com/is-bin/INTERSHOP.enfinity/WFS/CDS-CDS_Developer-Site/en_US/-/USD/ViewProductDetail-Start?ProductRef=7542-jms-1.1-fr-doc-oth-JSpec@CDS-CDS_Developer"
At="jms-${PV/./_}-fr-apidocs.zip"
DESCRIPTION="The Java Message Service (JMS) API."
HOMEPAGE="http://java.sun.com/products/jms/"
SRC_URI="${At}"
LICENSE="sun-bcla-jms"
SLOT=0
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc"
RDEPEND=">=virtual/jre-1.3"
DEPEND="app-arch/unzip
	>=virtual/jdk-1.3"
RESTRICT="fetch"

S="${WORKDIR}/${PN//sun-/}${PV}"

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${DOWNLOAD_PAGE}"
	einfo " 2. Accept the License Agreement"
	einfo " 3. Download ${At}"
	einfo " 4. Move the file to ${DISTDIR}"
	einfo
}

src_unpack() {
	unpack ${A}
	rm -v "${S}"/lib/*.jar
}

src_compile() {
	mkdir build
	cd src/share
	ejavac -nowarn -d "${S}"/build $(find . -name "*.java") || die "failed too build"
	if use doc ; then
		mkdir "${S}"/api
		javadoc -d "${S}"/api -quiet javax.jms
	fi

	cd "${S}"
	jar cf jms.jar -C build . || die "failed too create jar"
}

src_install() {
	java-pkg_dojar jms.jar
	use doc && java-pkg_dohtml -r api
}
