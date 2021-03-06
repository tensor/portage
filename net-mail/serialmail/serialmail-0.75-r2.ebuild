# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/serialmail/serialmail-0.75-r2.ebuild,v 1.9 2005/05/04 09:03:55 ferdy Exp $

inherit eutils

DESCRIPTION="A serialmail is a collection of tools for passing mail across serial links."
HOMEPAGE="http://cr.yp.to/serialmail.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz
	mirror://gentoo/${P}-patch.tar.bz2"

DEPEND="virtual/libc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88"

RDEPEND="virtual/libc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	>=sys-process/daemontools-0.76-r1"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="static"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.patch
	epatch ${WORKDIR}/${P}-smtpauth.patch
	epatch ${WORKDIR}/${P}-smtpauth_comp.patch
	sed -i "s:@CFLAGS@:${CFLAGS}:" conf-cc
	use static && LDFLAGS="${LDFLAGS} -static"
	sed -i "s:@LDFLAGS@:${LDFLAGS}:" conf-ld
}

src_compile() {
	grep -v man hier.c | grep -v doc > hier.c.tmp ; mv hier.c.tmp hier.c
	emake it man || die
}

src_install() {

	dobin setlock serialsmtp serialqmtp maildirsmtp maildirserial maildirqmtp

	dodoc AUTOTURN CHANGES FROMISP SYSDEPS THANKS TOISP \
		BLURB FILES INSTALL README TARGETS TODO VERSION

	doman maildirqmtp.1 maildirserial.1 maildirsmtp.1 \
		serialqmtp.1 serialsmtp.1 setlock.1
}
