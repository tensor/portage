# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/saru/saru-0.0.1.ebuild,v 1.7 2007/04/22 17:11:19 phreak Exp $

inherit eutils

DESCRIPTION="Heartbeat application to provide active active load balancers"
HOMEPAGE="http://www.ultramonkey.org/download/active_active/"
SRC_URI="http://www.ultramonkey.org/download/active_active/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc
	sys-cluster/ipvsadm
	dev-libs/popt
	dev-libs/glib
	>=dev-libs/vanessa-logger-0.0.6
	>=net-libs/vanessa-socket-0.0.7
	>=dev-libs/vanessa-adt-0.0.6
	>=dev-libs/libip_vs_user_sync-1.0.0
	>=sys-cluster/heartbeat-1.0.4
	net-firewall/iptables"

src_compile() {
	econf \
	--with-iptables-lib=/lib/iptables \
	--with-heartbeat-lib=/usr/lib/heartbeat \
	--with-heartbeat-fifo=/var/lib/heartbeat/api || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	#einstall DESTDIR=${D} || die "einstall failed"

	# saru binary
	exeinto /usr/sbin
	doexe saru/saru || die "doexe failed"

	dodir /usr/lib/heartbeat
	dosym /usr/sbin/saru /usr/lib/heartbeat/saru || die "dosym failed"

	# iptable module
	insinto /lib/iptables/
	insopts -m0755
	doins iptables/extensions/libipt_saru.so || die "doins failed"

	dodir /lib/modules/${KV}/kernel/net/ipv4/netfilter
	insinto /lib/modules/${KV}/kernel/net/ipv4/netfilter
	doins iptables/kernel/ipt_saru.o || die "doins failed"

	dodir /etc/saru
	newconfd "${FILESDIR}"/saru.conf saru

	insinto /etc/saru
	doins etc/saru/saru.conf || die "doins failed"

	newinitd "${FILESDIR}"/saru.init saru

	doman saru/saru.8 || die "doman failed"

	dodir /var/lib/heartbeat/api
	mknod -m 200 "${D}"/var/lib/heartbeat/api/saru_1.req p || die "mknod -m 200 failed!"
	mknod -m 600 "${D}"/var/lib/heartbeat/api/saru_1.rsp p || die "mknod -m 600 failed!"

	fowners 65:65 /var/lib/heartbeat/api/saru_1.req \
		/var/lib/heartbeat/api/saru_1.rsp || die "fowners failed!"

	dodoc ChangeLog README INSTALL TODO NEWS AUTHORS \
		patches/linux-2.4.20-outgoing_mac.hidden.patch \
		patches/linux-2.4.20-outgoing_mac.patch || die "dodoc failed"
	newdoc patches/README README.patches || die "newdoc failed"
}

pkg_postinst() {
	echo
	ebegin "Updating module dependencies ... "
	/sbin/depmod -a -F ${ROOT}/lib/modules/${KV}/build/System.map > /dev/null 2>&1
	eend $?
	echo
	einfo "Please remember to re-emerge saru when you upgrade your kernel!"
	echo
}
