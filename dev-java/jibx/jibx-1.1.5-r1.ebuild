# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jibx/jibx-1.1.5-r1.ebuild,v 1.4 2009/07/19 13:54:52 nixnut Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_all_version_separators '_')

DESCRIPTION="JiBX: Binding XML to Java Code"
HOMEPAGE="http://jibx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEP="dev-java/dom4j:1
	dev-java/ant-core:0
	dev-java/bcel:0
	java-virtuals/stax-api
	dev-java/xpp3:0"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${PN}"

java_prepare() {
	cd lib || die
	rm -v *.jar || die
	java-pkg_jar-from ant-core,bcel,dom4j-1,stax-api,xpp3
}

EANT_BUILD_XML="build/build.xml"
EANT_BUILD_TARGET="small-jars"

src_install() {
	java-pkg_dojar "${S}"/lib/${PN}*.jar

	dodoc changes.txt docs/binding.dtd docs/binding.xsd || die
	dohtml readme.html || die

	use doc && {
		java-pkg_dohtml -r docs/*
		cp -R starter "${D}/usr/share/doc/${PF}"
		cp -R tutorial "${D}/usr/share/doc/${PF}"
	}

	use source && java-pkg_dosrc build/src/* build/extras/*
}
