# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/silo/silo-1.4.13.ebuild,v 1.3 2007/02/07 14:40:05 gustavoz Exp $

inherit mount-boot flag-o-matic toolchain-funcs

DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="http://www.sparc-boot.org/pub/silo/${P}.tar.gz"
HOMEPAGE="http://www.sparc-boot.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* sparc"
IUSE="hardened"

PROVIDE="virtual/bootloader"

DEPEND="sys-fs/e2fsprogs
	sys-apps/sparc-utils"

ABI_ALLOW="sparc32"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Sanitized headers bug #162537
	sed -i -e 's/linux\/ufs_fs.h/non-linux\/ufs_fs.h/' second/fs/ufs.c

	epatch ${FILESDIR}/silo-1.4.x-noglibc_time.patch
}

src_compile() {
	filter-flags "-fstack-protector"

	if use hardened
	then
		make ${MAKEOPTS} CC="$(tc-getCC) -fno-stack-protector -fno-pic"
	else
		make ${MAKEOPTS} CC="$(tc-getCC)" || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog first-isofs/README.SILO_ISOFS docs/README*

	# Fix maketilo manpage
	rm ${D}/usr/share/man/man1/maketilo.1
	dosym /usr/share/man/man1/tilo.1 /usr/share/man/man1/maketilo.1
}

pkg_postinst() {
	ewarn "NOTE: If this is an upgrade to an existing SILO install,"
	ewarn "      you will need to re-run silo as the /boot/second.b"
	ewarn "      file has changed, else the system will fail to load"
	ewarn "      SILO at the next boot."
}
