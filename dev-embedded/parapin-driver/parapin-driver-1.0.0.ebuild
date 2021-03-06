# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/parapin-driver/parapin-driver-1.0.0.ebuild,v 1.2 2007/03/08 09:55:40 genstef Exp $

inherit linux-mod toolchain-funcs

DESCRIPTION="Parallel port pin kernel modules supported bug dev-embedded/parapin"
HOMEPAGE="http://parapin.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-driver}.tar.gz"

LICENSE="LGPL-2.1"
IUSE=""
KEYWORDS="x86 ~amd64"

S=${WORKDIR}/${P/-driver}

DEPEND="virtual/os-headers"
RDEPEND=""

MODULE_NAMES="kparapin(kernel:kparapin) parapindriver(kernel:parapindriver)"
BUILD_TARGETS="clean modules"

CONFIG_CHECK="PARPORT"
PARPORT_ERROR="Please make sure Device Drivers -> Parallel port support is enabled in your kernel"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="CC=$(tc-getCC) LINUX_SRC=${KV_DIR} -C .."
}

src_compile() {
	if kernel_is ge 2 6; then
		./setup-2.6.sh || die "setup-2.6.sh failed"
	else
		./setup-2.4.sh || die "setup-2.4.sh failed"
	fi
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	insinto /usr/include
	doins parapindriver.h
}
