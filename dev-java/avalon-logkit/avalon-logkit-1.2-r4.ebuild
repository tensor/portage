# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-1.2-r4.ebuild,v 1.4 2009/07/19 13:59:29 nixnut Exp $

EAPI="2"
JAVA_PKG_IUSE="doc javamail jms source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/logkit/v${PV}/LogKit-${PV}-src.tar.gz"
COMMON_DEP="
	javamail? (
		dev-java/sun-jaf:0
		java-virtuals/javamail
	)
	jms? ( java-virtuals/jms )"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	${COMMON_DEP}"

LICENSE="Apache-1.1"
SLOT="1.2"
KEYWORDS="amd64 ~ia64 ppc ppc64 ~x86"
IUSE=""

S="${WORKDIR}/LogKit-${PV}"

src_unpack() {
	unpack ${A}
	rm -rf "${S}/src/test/org"
	cd "${S}/lib"

	if use javamail; then
		java-pkg_jar-from sun-jaf
		java-pkg_jar-from --virtual javamail
	fi

	use jms && java-pkg_jar-from jms

}

# not generating api docs because we would
# need avalon-site otherwise
EANT_DOC_TARGET=""

# target is there but doesn't have tests
src_test() { :; }

src_install() {
	java-pkg_dojar "${S}/build/lib/logkit.jar"
	use doc && dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
