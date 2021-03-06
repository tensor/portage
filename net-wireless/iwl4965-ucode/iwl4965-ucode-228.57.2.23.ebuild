# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl4965-ucode/iwl4965-ucode-228.57.2.23.ebuild,v 1.4 2009/04/19 14:44:38 maekke Exp $

MY_P=iwlwifi-4965-ucode-${PV}

DESCRIPTION="Intel (R) Wireless WiFi Link 4965AGN ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_P}.tgz"

LICENSE="Intel"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	true;
}

src_install() {
	insinto /lib/firmware
	doins iwlwifi-4965-2.ucode || die
	dodoc README* || die "dodoc failed"
}

pkg_postinst() {
	elog "Due to ucode API change this version of ucode works only with kernels"
	elog ">=2.6.27. If you need ucode for older versions please install it with"
	elog "emerge net-wireless/iwl4965-unicode:0"
	elog "For more information take a look at bugs.gentoo.org/235007"
}
