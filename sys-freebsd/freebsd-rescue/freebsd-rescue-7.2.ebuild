# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-rescue/freebsd-rescue-7.2.ebuild,v 1.1 2009/05/22 13:40:51 aballier Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's rescue binaries"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE="atm nis"

SRC_URI="mirror://gentoo/${UBIN}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${USBIN}.tar.bz2
		mirror://gentoo/${GNU}.tar.bz2
		mirror://gentoo/${SYS}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${RESCUE}.tar.bz2"

RDEPEND=""
DEPEND="sys-devel/flex
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/rescue"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} NO_ATM= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "

	for flag in atm nis; do
		if use ${flag} && ! built_with_use sys-libs/freebsd-lib ${flag}; then
			die "You can't add ${flag} support here without adding it to sys-libs/freebsd-lib"
		fi
	done

#	append-flags -fno-stack-protector -fno-stack-protector-all
}

src_unpack() {
	freebsd_src_unpack

	# As they are patches from ${WORKDIR} apply them by hand
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}"-5.4-gentoo.patch
	epatch "${FILESDIR}/${PN}"-7.1-zlib.patch
}
