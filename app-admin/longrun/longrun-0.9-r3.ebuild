# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/longrun/longrun-0.9-r3.ebuild,v 1.5 2008/10/23 02:05:45 flameeyes Exp $

inherit eutils linux-info toolchain-funcs

DESCRIPTION="A utility to control Transmeta's Crusoe and Efficeon processors"
HOMEPAGE="http://freshmeat.net/projects/longrun/"

DEBIAN_PATCH_VERSION="19"
DEBIAN_PATCH="${PN}_${PV}-${DEBIAN_PATCH_VERSION}.diff.gz"
SRC_URI="
	mirror://kernel/linux/utils/cpu/crusoe/${P}.tar.bz2
	mirror://debian/pool/main/l/${PN}/${DEBIAN_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

CONFIG_CHECK="X86_MSR X86_CPUID"

ERROR_X86_MSR="
Longrun needs a MSR device to function. Please select
MSR under Processor type and features. It can be build
directly into the kernel or as a module.
"

ERROR_X86_CPUID="
Longrun needs a CPUID device to function. Please select
CPUID under Processor type and features. It can be
build directly into the kernel or as a module.
"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch "${DISTDIR}/${DEBIAN_PATCH}"
	epatch "${FILESDIR}/${PV}-makefile_cflags.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc MAKEDEV-cpuid-msr
}

pkg_postinst() {
	if linux_chkconfig_module X86_MSR; then
		elog "You have compiled MSR as a module."
		elog "You need to load it before using Longrun."
		elog "The module is called msr."
		elog
	fi

	if linux_chkconfig_module X86_CPUID; then
		elog "You have compiled CPUID as a module."
		elog "You need to load it before using Longrun."
		elog "The module is called cpuid."
	fi
}
