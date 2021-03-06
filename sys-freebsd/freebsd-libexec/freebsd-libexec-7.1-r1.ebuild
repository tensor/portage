# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-libexec/freebsd-libexec-7.1-r1.ebuild,v 1.1 2009/05/18 17:01:47 flameeyes Exp $

EAPI=2

inherit bsdmk freebsd pam

DESCRIPTION="FreeBSD libexec things"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

SRC_URI="mirror://gentoo/${LIBEXEC}.tar.bz2
	mirror://gentoo/${UBIN}.tar.bz2
	mirror://gentoo/${BIN}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*[nis?]
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"
RDEPEND="${RDEPEND}
	xinetd? ( sys-apps/xinetd )"

S="${WORKDIR}/libexec"

PATCHES="${FILESDIR}/${PN}-setXid.patch
	${FILESDIR}/${PN}-nossp.patch
	${FILESDIR}/${PN}-7.0-libfallback.patch"

# Remove sendmail, tcp_wrapper and other useless stuff
REMOVE_SUBDIRS="smrsh mail.local tcpd telnetd rshd rlogind lukemftpd ftpd"

IUSE="pam ssl kerberos ipv6 nis xinetd"

pkg_setup() {
	use ipv6 || mymakeopts="${mymakeopts} WITHOUT_INET6= WITHOUT_INET6_SUPPORT= "
	use kerberos || mymakeopts="${mymakeopts} WITHOUT_KERBEROS_SUPPORT= "
	use nis || mymakeopts="${mymakeopts} WITHOUT_NIS= "
	use pam || mymakeopts="${mymakeopts} WITHOUT_PAM_SUPPORT= "
	use ssl || mymakeopts="${mymakeopts} WITHOUT_OPENSSL= "

	mymakeopts="${mymakeopts} WITHOUT_SENDMAIL= WITHOUT_PF= WITHOUT_RCMDS= "
}

src_prepare() {
	ln -s /usr/include "${WORKDIR}/include"
}

src_compile() {
	NOSSP_FLAGS="$(test-flags -fno-stack-protector -fno-stack-protector-all)"
	export NOSSP_FLAGS
	freebsd_src_compile
}

src_install() {
	freebsd_src_install

	insinto /etc
	doins "${WORKDIR}/etc/gettytab"
	newinitd "${FILESDIR}/bootpd.initd" bootpd
	newconfd "${FILESDIR}/bootpd.confd" bootpd

	if use xinetd; then
		for rpcd in rstatd rusersd walld rquotad sprayd; do
			insinto /etc/xinetd.d
			newins "${FILESDIR}/${rpcd}.xinetd" ${rpcd}
		done
	fi
}
