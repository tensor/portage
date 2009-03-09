# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/conntrack-tools/conntrack-tools-0.9.11.ebuild,v 1.2 2009/03/08 13:47:44 pva Exp $

EAPI="2"
inherit linux-info eutils

DESCRIPTION="Connection tracking userspace tools"
HOMEPAGE="http://conntrack-tools.netfilter.org"
SRC_URI="http://www.netfilter.org/projects/conntrack-tools/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="
	>=net-libs/libnfnetlink-0.0.40
	>=net-libs/libnetfilter_conntrack-0.0.99
	!net-firewall/conntrack"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 18 ; then
		die "${PN} requires at least 2.6.18 kernel version"
	fi

	#netfilter core team has changed some option names with kernel 2.6.20
	if kernel_is lt 2 6 20 ; then
		CONFIG_CHECK="IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="NF_CT_NETLINK"
	fi
	CONFIG_CHECK="${CONFIG_CHECK} NF_CONNTRACK NF_CONNTRACK_IPV4
		NETFILTER_NETLINK NF_CONNTRACK_EVENTS"

	check_extra_config
}

src_prepare() {
	epatch "${FILESDIR}/${P}-INT_MAX.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/conntrackd.initd-r1" conntrackd || die
	newconfd "${FILESDIR}/conntrackd.confd-r1" conntrackd || die

	insinto /etc/conntrackd
	doins doc/stats/conntrackd.conf || die

	dodoc AUTHORS ChangeLog || die
	insinto /usr/share/doc/${PF}
	doins -r doc/* || die
}
