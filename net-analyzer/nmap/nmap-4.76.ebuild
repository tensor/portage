# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-4.76.ebuild,v 1.10 2009/05/02 17:34:33 spock Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://nmap.org/"
SRC_URI="http://download.insecure.org/nmap/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="gtk lua ssl"

DEPEND="dev-libs/libpcre
	net-libs/libpcap
	gtk? ( >=x11-libs/gtk+-2.6
		   >=dev-python/pygtk-2.6
		   || ( >=dev-lang/python-2.5[sqlite]
				>=dev-python/pysqlite-2 )
		 )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-4.75-include.patch"
	epatch "${FILESDIR}/${PN}-4.75-nolua.patch"
	epatch "${FILESDIR}/su-to-zenmap.sh.diff"
}

src_configure() {
	local myconf=""

	if use lua ; then
		if has_version ">=dev-lang/lua-5.1.3-r1" &&
		   built_with_use dev-lang/lua deprecated ; then
			myconf="--with-liblua"
		else
			myconf="--with-liblua=included"
		fi
	else
		myconf="--without-liblua"
	fi

	econf \
		--with-libdnet=included \
		"${myconf}" \
		$(use_with gtk zenmap) \
		$(use_with ssl openssl) || die
}

src_install() {
	LC_ALL=C emake DESTDIR="${D}" -j1 nmapdatadir=/usr/share/nmap install || die
	dodoc CHANGELOG HACKING docs/README docs/*.txt || die

	use gtk && doicon "${FILESDIR}/nmap-logo-64.png"
}
