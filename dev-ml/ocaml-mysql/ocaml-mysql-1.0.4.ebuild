# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-mysql/ocaml-mysql-1.0.4.ebuild,v 1.3 2008/04/20 14:13:50 maekke Exp $

inherit findlib eutils

EAPI="1"

IUSE="doc +ocamlopt"

DESCRIPTION="A package for ocaml that provides access to mysql databases."
SRC_URI="http://raevnos.pennmush.org/code/${PN}/${P}.tar.gz"
HOMEPAGE="http://raevnos.pennmush.org/code/ocaml-mysql/index.html"

DEPEND=">=dev-lang/ocaml-3.06
	>=virtual/mysql-4.0"

RDEPEND="$DEPEND"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ppc x86"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.0.3-head.patch"
	epatch "${FILESDIR}/${PN}-1.0.3-shtool-r1.patch"
}

src_compile()
{
	econf
	emake all || die "make failed"
	if use ocamlopt; then
		emake opt || die "make opt failed"
	fi
}

src_install()
{
	findlib_src_preinst
	emake install || die "make install failed"

	use doc && dohtml -r doc/html/*
	dodoc CHANGES README VERSION
}
