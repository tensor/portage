# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jibx-tools/jibx-tools-1.1.5.ebuild,v 1.1 2008/02/21 23:17:32 betelgeuse Exp $

EAPI=1
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_all_version_separators '_')

DESCRIPTION="JiBX: Binding XML to Java Code - Generators"
HOMEPAGE="http://jibx.sourceforge.net/"
SRC_URI="mirror://sourceforge/jibx/jibx_${MY_PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

COMMON_DEP="
	dev-java/bcel:0
	dev-java/jsr173:0
	~dev-java/jibx-${PV}"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/jibx"

src_unpack() {
	unpack ${A}
	#http://jira.codehaus.org/browse/JIBX-207
	epatch "${FILESDIR}/1.1.5-build.patch"
	java-ant_rewrite-classpath "${S}/build/build.xml"
	rm -v "${S}"/lib/*.jar || die
}

EANT_FILTER_COMPILER="ecj-3.3"
EANT_BUILD_XML="build/build.xml"
EANT_BUILD_TARGET="jar-tools"
EANT_GENTOO_CLASSPATH="bcel,jsr173,jibx"

src_install() {
	java-pkg_register-dependency jibx

	java-pkg_dojar "${S}/lib"/jibx-*.jar
	use source && java-pkg_dosrc "${S}"/build/src/* "${S}"/build/extras/*
}
