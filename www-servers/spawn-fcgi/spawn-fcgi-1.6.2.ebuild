# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/spawn-fcgi/spawn-fcgi-1.6.2.ebuild,v 1.5 2009/05/14 18:45:25 jer Exp $

EAPI="2"

DESCRIPTION="A FCGI spawner for lighttpd and cherokee and other webservers"
HOMEPAGE="http://redmine.lighttpd.net/projects/spawn-fcgi"
SRC_URI="http://www.lighttpd.net/download/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="ipv6"

DEPEND=""
RDEPEND="!<=www-servers/lighttpd-1.4.20
	!<=www-servers/cherokee-0.98.1"

src_configure() {
	econf \
		$(use_enable ipv6 )
}

src_install() {
	emake DESTDIR="${D}" install || die 'install failed'
	dodoc README NEWS

	newconfd "${FILESDIR}"/spawn-fcgi.confd spawn-fcgi
	newinitd "${FILESDIR}"/spawn-fcgi.initd spawn-fcgi
	#pidfile dir
	keepdir /var/run/spawn-fcgi
	fperms 0700 /var/run/spawn-fcgi
}
