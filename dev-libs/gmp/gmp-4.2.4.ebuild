# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.2.4.ebuild,v 1.8 2009/02/21 22:05:51 vapier Exp $

inherit flag-o-matic eutils libtool

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://gmplib.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"
#	doc? ( http://www.nada.kth.se/~tege/${PN}-man-${PV}.pdf )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="nocxx" #doc

RDEPEND=""
DEPEND=""

src_unpack () {
	unpack ${A}
	cd "${S}"
	[[ -d ${FILESDIR}/${PV} ]] && EPATCH_SUFFIX="diff" EPATCH_FORCE="yes" epatch "${FILESDIR}"/${PV}
	epatch "${FILESDIR}"/${PN}-4.1.4-noexecstack.patch
	epatch "${FILESDIR}"/${PN}-4.2.3-ABI-multilib.patch
	epatch "${FILESDIR}"/${PN}-4.2.1-s390.diff

	sed -i -e 's:ABI = @ABI@:GMPABI = @GMPABI@:' \
		Makefile.in */Makefile.in */*/Makefile.in

	# note: we cannot run autotools here as gcc depends on this package
	elibtoolize
}

src_compile() {
	# GMP believes hppa2.0 is 64bit
	local is_hppa_2_0
	if [[ ${CHOST} == hppa2.0-* ]] ; then
		is_hppa_2_0=1
		export CHOST=${CHOST/2.0/1.1}
	fi

	# ABI mappings (needs all architectures supported)
	case ${ABI} in
		32|x86)       export GMPABI=32;;
		64|amd64|n64) export GMPABI=64;;
		o32|n32)      export GMPABI=${ABI};;
	esac

	econf \
		--localstatedir=/var/state/gmp \
		--disable-mpfr \
		--disable-mpbsd \
		$(use_enable !nocxx cxx) \
		|| die "configure failed"

	# Fix the ABI for hppa2.0
	if [[ -n ${is_hppa_2_0} ]] ; then
		sed -i \
			-e 's:pa32/hppa1_1:pa32/hppa2_0:' \
			"${S}"/config.h || die
		export CHOST=${CHOST/1.1/2.0}
	fi

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc

	#use doc && cp "${DISTDIR}"/gmp-man-${PV}.pdf "${D}"/usr/share/doc/${PF}/
}
