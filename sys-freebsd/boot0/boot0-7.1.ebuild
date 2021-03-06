# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/boot0/boot0-7.1.ebuild,v 1.1 2009/01/22 20:59:52 the_paya Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's bootloader"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${SYS}.tar.bz2"

RDEPEND=""
DEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-lib-${RV}*"

S="${WORKDIR}/sys/boot"

PATCHES="${FILESDIR}/boot0-7.0-gentoo.patch"

src_unpack() {
	freebsd_src_unpack

	grep -lr --null -- -ffreestanding "${S}" | xargs -0 sed -i -e \
		"s:-ffreestanding:-ffreestanding $(test-flags -fno-stack-protector -fno-stack-protector-all):g" || die
	sed -e '/-fomit-frame-pointer/d' -e '/-mno-align-long-strings/d' \
		-i "${S}"/i386/boot2/Makefile \
		-i "${S}"/i386/gptboot/Makefile || die
}

src_install() {
	dodir /boot/defaults

	mkinstall FILESDIR=/boot || die "mkinstall failed"
}
