# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/b43-fwcutter/b43-fwcutter-010.ebuild,v 1.2 2008/01/17 15:59:59 josejx Exp $

inherit toolchain-funcs

DESCRIPTION="Firmware Tool for Broadcom 43xx based wireless network devices
using the mac80211 wireless stack"
HOMEPAGE="http://bu3sch.de/b43/fwcutter"
SRC_URI="http://bu3sch.de/b43/fwcutter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE=""
DEPEND=""
RDEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	# Install fwcutter
	exeinto /usr/bin
	doexe ${PN}
	doman ${PN}.1
	dodoc README
}

pkg_postinst() {
	einfo
	einfo "Firmware may be downloaded from http://linuxwireless.org."
	einfo
	ewarn "This version supports 2.6.25 and newer kernels.  If this"
	ewarn "is not what you want, please emerge b43-fwcutter-009."
	einfo

	einfo "Please read this forum thread for help and troubleshooting:"
	einfo "http://forums.gentoo.org/viewtopic-t-409194.html"
	einfo
}
