# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-pool/commons-pool-1.4.ebuild,v 1.4 2009/03/18 15:03:51 ranger Exp $

EAPI=1
JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Provides general purpose object pooling API"
HOMEPAGE="http://commons.apache.org/pool/"
SRC_URI="mirror://apache/commons/pool/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	test? (
		dev-java/ant-junit
		dev-java/junit:0
	)"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

EANT_BUILD_TARGET="build-jar"

src_test() {
	ANT_TASKS="ant-junit" eant -Dclasspath="$(java-pkg_getjars junit)" test
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc README.txt RELEASE-NOTES.txt || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/org
}
