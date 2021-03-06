# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-3.1.3.ebuild,v 1.2 2009/03/29 16:48:01 betelgeuse Exp $

EAPI="2"
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A parser generator for C++, C#, Java, and Python"
HOMEPAGE="http://www.antlr.org/"
# You need to generate v3 grammars so that boostrapping works
SRC_URI="http://www.antlr.org/download/${P}.tar.gz
	mirror://gentoo/${P}-generated.tar.bz2"
LICENSE="BSD"
SLOT="3"
KEYWORDS="~x86"
IUSE=""

COMMON_DEPEND=">=dev-java/stringtemplate-3.2
	 >=dev-java/antlr-2.7.7:0[java]"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.5"

java_prepare() {
	rm -v lib/*.jar lib/.*.jar || die
	rm -v runtime/ActionScript/project/lib/*.jar || die
	# We must bundle this as we can't depend on ourselves
	cp -v "${WORKDIR}"/*.java tool/src/main/antlr/org/antlr/grammar/v3 || die
}

antlr2() {
	java -cp $(java-pkg_getjars antlr) antlr.Tool "${@}" || die "antlr2 failed"
}

build_antlr() {
	cd "${S}"
	local dest="${1}"
	# runtime
	find runtime -name "*.java" > "${T}/sources" || die
	# tool
	find tool/src/main -name "*.java" >> "${T}/sources" || die
	ejavac -d "${dest}" -cp $(java-pkg_getjars antlr,stringtemplate) "@${T}/sources"
}

# Uses maven so let's just do things manully for now
# when bumping use jardiff and apicheck to make sure
# produced jars are good
src_compile() {
	einfo "Bootstrapping antlr3 with bundled sources"
	cd tool/src/main/antlr2/org/antlr/grammar/v2/ || die
	# the command line only takes one at a time
	for grammar in *.g; do
		antlr2 ${grammar} || die
	done

	cd "${S}" || die
	mkdir bootstrap || die
	build_antlr bootstrap

	einfo "Building v3 grammars with boostrapped antlr"
	cd tool/src/main/antlr/org/antlr/grammar/v3/ || die
	rm -v *.java || die
	local cp="${S}/bootstrap:${S}/tool/src/main/resources/"
	java -cp "${cp}":$(java-pkg_getjars antlr,stringtemplate) \
		org.antlr.Tool *.g || die "building v3 grammars failed"

	cd "${S}"
	mkdir build || die
	cp -r "${S}"/tool/src/main/resources/* build || die
	build_antlr build

	# jar things up
	cd build
	find -type f > "${T}/classes" || die
	jar cf ${PN}3.jar "@${T}/classes" || die "jar failed"
}

src_install() {
	java-pkg_dojar build/antlr3.jar
	java-pkg_dolauncher antlr3 --main org.antlr.Tool

	use source && java-pkg_dosrc tool/src/main/org \
		runtime/Java/src/main/java/org/
}

pkg_postinst() {
	elog "Currently the ebuild only has support for the Java backend."
	elog "gunit support is not included yet either."
}
