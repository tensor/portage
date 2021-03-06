# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxme/jaxme-0.5.2.ebuild,v 1.1 2009/05/23 00:55:55 ali_bush Exp $

EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

MY_PN=ws-${PN}
MY_P=${MY_PN}-${PV}
DESCRIPTION="JaxMe 2 is an open source implementation of JAXB, the specification for Java/XML binding."
HOMEPAGE="http://ws.apache.org/jaxme/index.html"
SRC_URI="mirror://apache/ws/${PN}/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/antlr:0[java]
	dev-db/hsqldb:0
	>=dev-java/xerces-2.7
	=dev-java/junit-3.8*
	>=dev-java/log4j-1.2.8
	dev-java/xmldb:0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

# We do it later
JAVA_PKG_BSFIX="off"

java_prepare() {
	cd "${S}/prerequisites"
	rm *.jar
	java-pkg_jarfrom antlr
	java-pkg_jarfrom hsqldb hsqldb.jar hsqldb-1.7.1.jar
	java-pkg_jarfrom junit
	java-pkg_jarfrom log4j log4j.jar log4j-1.2.8.jar
	java-pkg_jarfrom xerces-2
	java-pkg_jarfrom xmldb xmldb-api.jar xmldb-api-20021118.jar
	java-pkg_jarfrom xmldb xmldb-api-sdk.jar xmldb-api-sdk-20021118.jar
	java-pkg_jarfrom --build-only ant-core ant.jar ant-1.5.4.jar
	java-pkg_jarfrom --build-only ant-core ant.jar ant.jar

	# Special case: jaxme uses ant/*.xml files, so rewriting them by hand
	# is better:
	cd "${S}"
	for i in build.xml ant/*.xml src/webapp/web.xml src/test/jaxb/build.xml; do
		java-ant_bsfix_one "${i}"
	done

	# Patch marshal classes to be abstract for build to succeed
	epatch "${FILESDIR}/${P}-fix_marshallers.patch"
}

EANT_BUILD_TARGET="all"
EANT_EXTRA_ARGS=""
EANT_TEST_ANT_TASKS="hsqldb"

src_compile() {
	use doc && EANT_EXTRA_ARGS+="-Dbuild.apidocs=dist/doc/api"

	java-pkg-2_src_compile
}

src_install() {
	pushd dist > /dev/null
	for jar in *.jar; do
		java-pkg_newjar ${jar} ${jar/-${PV}/}
	done
	popd > /dev/null

	dodoc NOTICE || die

	if use doc; then
		java-pkg_dojavadoc dist/doc/api
		dohtml -r src/documentation/manual
	fi
	use source && java-pkg_dosrc src/{pm,jaxme,js,api,webapp,xs}/*
}
