# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ufdbguard/ufdbguard-1.16.ebuild,v 1.1 2009/03/18 17:08:49 bass Exp $

inherit eutils
DESCRIPTION="ufdbGuard is a redirector for the Squid internet proxy."
HOMEPAGE="http://ufdbguard.sf.net"
SRC_URI="mirror://sourceforge/ufdbguard/ufdbGuard-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-libs/openssl
		app-arch/bzip2
		dev-util/yacc
		sys-devel/flex"
RDEPEND="${DEPEND}
		net-misc/wget"

S="${WORKDIR}/ufdbGuard-${PV}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-ufdb-config=/etc/ufdbguard \
		--with-ufdb-logdir=/var/log/ufdbguard \
		--with-ufdb-dbhome=/etc/ufdbguard/blacklists \
		--infodir=/usr/share/info \
		--with-ufdb-images_dir=/usr/share/ufdbguard/images \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	dodoc CHANGELOG INSTALL README
	dodoc src/UFDB src/sampleufdbGuard.conf

	dobin src/ufdbAnalyse src/ufdbGenTable src/ufdbGrab src/ufdbhttpd src/mtserver/ufdbgclient src/mtserver/ufdbguardd

	dodir /etc/ufdbguard/blacklists
	insinto /etc/ufdbguard
	doins src/ufdbGuard.conf

	dodir /usr/share/ufdbguard/images
	insinto /usr/share/ufdbguard/images
	doins src/images/*

	newconfd ${FILESDIR}/ufdbguard.confd ufdbguard
	#newconfd ${FILESDIR}/ufdbhttpd.confd ufdbhttpd
	newinitd ${FILESDIR}/ufdbguard.initd ufdbguard
	#newinitd ${FILESDIR}/ufdbhttpd.initd ufdbhttpd

}

pkg_postinst() {
	einfo "You can configure deamons options in:"
	einfo " /etc/conf.d/ufdbguard"
#     einfo " /etc/conf.d/ufdbhttpd"
	einfo "Add ufdbguard port to services:"
	einfo ' echo "ufdbguardd      3977/tcp" >> /etc/services '
}
