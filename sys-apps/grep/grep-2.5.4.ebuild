# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.4.ebuild,v 1.4 2009/04/09 16:09:35 loki_val Exp $

inherit eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nls pcre static"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	pcre? ( <=dev-libs/libpcre-7.8 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.5.3-po-builddir-fix.patch
	epatch "${FILESDIR}"/${PN}-2.5.3-nls.patch
}

src_compile() {
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		$(use_enable pcre perl-regexp) \
		$(use elibc_FreeBSD || echo --without-included-regex) \
		|| die "econf failed"

	use static || sed -i 's:-lpcre:-Wl,-Bstatic -lpcre -Wl,-Bdynamic:g' src/Makefile

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
