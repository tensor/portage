# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-libexec/freebsd-libexec-6.2-r2.ebuild,v 1.2 2007/10/16 08:54:50 uberlord Exp $

inherit bsdmk freebsd pam

DESCRIPTION="FreeBSD libexec things"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE="pam ssl kerberos ipv6 nis"

SRC_URI="mirror://gentoo/${LIBEXEC}.tar.bz2
	mirror://gentoo/${UBIN}.tar.bz2
	mirror://gentoo/${BIN}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"

S="${WORKDIR}/libexec"

PATCHES="${FILESDIR}/${PN}-setXid.patch
	${FILESDIR}/${PN}-nossp.patch
	${FILESDIR}/${PN}-6.1-libfallback.patch
	${FILESDIR}/${PN}-6.2-dl_iterate_phdr.patch"

# Remove sendmail, tcp_wrapper and other useless stuff
REMOVE_SUBDIRS="smrsh mail.local tcpd telnetd rshd rlogind lukemftpd ftpd"

pkg_setup() {
	use pam || mymakeopts="${mymakeopts} NO_PAM= "
	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	use kerberos || mymakeopts="${mymakeopts} NO_KERBEROS= "
	use ipv6 || mymakeopts="${mymakeopts} NO_INET6= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "

	mymakeopts="${mymakeopts} NO_SENDMAIL= NO_PF= "
}

src_unpack() {
	freebsd_src_unpack

	ln -s /usr/include "${WORKDIR}/include"
}

src_compile() {
	NOSSP_FLAGS="$(test-flags -fno-stack-protector -fno-stack-protector-all)"
	export NOSSP_FLAGS
	freebsd_src_compile
}

src_install() {
	freebsd_src_install

	newinitd "${FILESDIR}/bootpd.initd"
	newconfd "${FILESDIR}/bootpd.confd"

	insinto /etc
	doins "${WORKDIR}/etc/gettytab"
}
