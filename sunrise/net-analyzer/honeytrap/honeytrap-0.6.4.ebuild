# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

DESCRIPTION="Network security tool for observing network services via low-interactive honeypot"
HOMEPAGE="http://honeytrap.mwcollect.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcap-mon ipq-mon efence debug"

RDEPEND="pcap-mon? ( virtual/libpcap )
	ipq-mon? ( net-firewall/iptables )
	!pcap-mon? ( !ipq-mon? ( net-firewall/iptables ) )"
DEPEND="${RDEPEND}
	efence? ( dev-util/efence )"

pkg_setup() {
	enewgroup honeytrap
	enewuser honeytrap -1 -1 /sbin/nologin honeytrap

	if ! use pcap-mon && ! use ipq-mon ; then
		ewarn "You didn't choose any connection monitor."
		ewarn "Currently pcap-based and ip_queue-based monitors are supported."
		ewarn "Defaulting to iptables; if this is not what you want,"
		ewarn "you should add pcap-mon to your USE and re-emerge this ebuild."
		epause 3
	fi

	if use efence; then
		ewarn "You have enabled a link with Electric Fence malloc debugger."
		ewarn "It is known that Honeytrap will not work with efence and xen-sources."
		epause 3
	fi

	use ipq-mon && CONFIG_CHECK="IP_NF_QUEUE"
	linux-info_pkg_setup
}

src_compile() {
	local myconf
	if use ipq-mon ; then
		myconf="${myconf} --with-libipq-includes=/usr/include/libipq"
	elif ! use pcap-mon && ! use ipq-mon ; then
		myconf="${myconf} --with-libipq-includes=/usr/include/libipq"
	fi

	econf \
		$(use_with pcap-mon) \
		$(use_with ipq-mon) \
		$(use_enable efence) \
		$(use_enable debug) \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# Few hacks needed. Feel free to figure out a better way.
	# A. Correct fuzzy locations.
	mv "${S}"/etc/etc/* "${S}"/etc/	|| die

	emake DESTDIR="${D}" install || die "emake install failed"

	# B. Unfortunately the dynamic shared plugins are installed into /etc/honeytrap/plugins by default.
	# The easiest way is to just move them and put them into /usr/src/honeytrap_dynamicsrc (cf. Snort).
	dodir /usr/src
	mv "${D}"/etc/honeytrap/plugins "${D}"/usr/src/honeytrap_dynamicsrc || die

	# As the ebuild includes a modified version of this file, no need to copy this into the live system.
	rm -f "${D}"/etc/honeytrap/honeytrap.conf*

	mv "${D}"/etc/honeytrap/ports.conf.dist "${D}"/etc/honeytrap/ports.conf

	dodoc README NEWS TODO ChangeLog

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	cp "${FILESDIR}"/honeytrap.conf "${D}"/etc/honeytrap/

	keepdir /var/log/honeytrap
	keepdir /var/log/honeytrap/attacks
	keepdir /var/log/honeytrap/downloads

	fowners -R honeytrap:honeytrap /var/log/honeytrap
	fperms 0700 -R /var/log/honeytrap
}

pkg_postinst() {
	ewarn
	ewarn "WARNING (from the README):"
	ewarn "Honeytrap is a low-interactive honeypot and therefore detectable."
	ewarn "It  is  written  in  C  and thus potentially vulnerable to buffer"
	ewarn "overflow attacks. Take care. Running in mirror mode is dangerous."
	ewarn "Attacks  may  be directed to the attacker, appearing to come from"
	ewarn "your system. Use with caution."
	ewarn
}
