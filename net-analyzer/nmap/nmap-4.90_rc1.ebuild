# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-4.90_rc1.ebuild,v 1.1 2009/06/27 09:03:51 patrick Exp $

EAPI="2"

inherit eutils flag-o-matic

MY_P=${P//_rc1/RC1}

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://nmap.org/"
SRC_URI="http://download.insecure.org/nmap/dist/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="gtk lua ssl"

DEPEND="dev-libs/libpcre
	net-libs/libpcap
	gtk? ( >=x11-libs/gtk+-2.6
		   >=dev-python/pygtk-2.6
		   || ( >=dev-lang/python-2.5[sqlite]
				>=dev-python/pysqlite-2 )
		 )
	ssl? ( dev-libs/openssl )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-4.75-include.patch"
	epatch "${FILESDIR}/${PN}-4.75-nolua.patch"
	sed -i -e 's/-m 755 -s ncat/-m 755 ncat/' ncat/Makefile.in
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
	LC_ALL=C emake DESTDIR="${D}" -j1 STRIP=: nmapdatadir=/usr/share/nmap install || die
	dodoc CHANGELOG HACKING docs/README docs/*.txt || die

	use gtk && doicon "${FILESDIR}/nmap-logo-64.png"
}
