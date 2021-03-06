# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-digester/commons-digester-1.8.ebuild,v 1.7 2008/03/12 01:16:49 ken69267 Exp $

EAPI=1
JAVA_PKG_IUSE="doc examples source test"

inherit eutils java-pkg-2 java-ant-2

MY_P="${P}-src"
DESCRIPTION="Reads XML configuration files to provide initialization of various Java objects within the system."
HOMEPAGE="http://jakarta.apache.org/commons/digester/"
SRC_URI="mirror://apache/jakarta/commons/digester/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

# 1.3 support might be possible by adding an additional depend on
# xml-commons[-external, but 1.3 is gone anyway
RDEPEND=">=virtual/jre-1.4
	dev-java/commons-beanutils:1.6
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/junit:0 )
	${RDEPEND}"

S="${WORKDIR}/${P}-src"

# don't rewrite build.xml in examples
JAVA_PKG_BSFIX_ALL="no"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-build.xml-jar-target.patch"

	# this build.xml honours build.properties so we use it for common depends
	# needed for both compile and test, so getjar is called only once
	echo "commons-beanutils.jar=$(java-pkg_getjar commons-beanutils-1.6 \
		commons-beanutils.jar)" > build.properties
	echo "commons-collections.jar=$(java-pkg_getjar commons-collections \
		commons-collections.jar)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging \
		commons-logging.jar)" >> build.properties
}

src_test() {
	eant -Djunit.jar="$(java-pkg_getjar --build-only junit junit.jar)" test
}

src_install() {
	java-pkg_dojar "dist/${PN}.jar"

	dodoc NOTICE.txt RELEASE-NOTES.txt || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/org
	use examples && java-pkg_doexamples src/examples
}
