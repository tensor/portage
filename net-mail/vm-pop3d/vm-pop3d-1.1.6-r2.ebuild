# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vm-pop3d/vm-pop3d-1.1.6-r2.ebuild,v 1.1 2005/05/21 21:01:45 ferdy Exp $

inherit eutils

DESCRIPTION="POP3 server"
HOMEPAGE="http://www.reedmedia.net/software/virtualmail-pop3d/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/mail/pop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="pam debug"

DEPEND="virtual/libc
	pam? (
		virtual/pam
		>=net-mail/mailbase-0.00-r8
	)"

pkg_setup() {
	if use pam && ! built_with_use net-mail/mailbase pam ; then
		echo
		eerror
		eerror "${PN} needs net-mail/mailbase to be built with USE flag pam"
		eerror "  activated. Please rebuild net-mail/mailbase with pam"
		eerror
		echo
		die "mailbase has to be built with pam flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/makefile.in.diff
}

src_compile() {
	econf \
		$(use_enable pam) \
		$(use_enable debug) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc AUTHORS CHANGES COPYING FAQ INSTALL README TODO

	newinitd "${FILESDIR}/vm-pop3d.rc3" vm-pop3d || \
		die "failed to install initd file"
	newconfd "${FILESDIR}/vm-pop3d.confd" vm-pop3d || \
		die "failed to install confd file"

	if use pam ; then
		dodir /etc/pam.d/
		dosym /etc/pam.d/pop /etc/pam.d/vm-pop3d
	fi
}
