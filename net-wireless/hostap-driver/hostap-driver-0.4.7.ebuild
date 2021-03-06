# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap-driver/hostap-driver-0.4.7.ebuild,v 1.5 2006/07/18 12:30:57 genstef Exp $

inherit toolchain-funcs eutils linux-mod

DESCRIPTION="Driver for Intersil Prism2/2.5/3 based IEEE 802.11b wireless LAN products"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ppc x86"
IUSE="pcmcia"
SLOT="0"

RDEPEND=">=net-wireless/wireless-tools-25
	pcmcia? ( virtual/pcmcia )"

BUILD_TARGETS="all"
MODULESD_HOSTAP_DOCS="README"
MODULESD_HOSTAP_CRYPT_WEP_ENABLED="no"
MODULESD_HOSTAP_CRYPT_TKIP_ENABLED="no"
MODULESD_HOSTAP_CRYPT_CCMP_ENABLED="no"

CONFIG_CHECK="!HOSTAP NET_RADIO"
ERROR_HOSTAP="${P} requires the in-kernel version of the hostap driver to be disabled (CONFIG_HOSTAP)"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pcmcia_src_unpack() {
	local pcmcia_tbz="${ROOT}/usr/src/pcmcia-cs/pcmcia-cs-build-env.tbz2"
	local PCMCIA_SOURCE_DIR="${WORKDIR}/pcmcia-cs/"

	# if the kernel has pcmcia support built in, then we just ignore all this.
	if linux_chkconfig_present PCMCIA; then
		einfo "Kernel based PCMCIA support has been detected."
	else
		if kernel_is 2 6; then
			einfo "We have detected that you are running a 2.6 kernel"
			einfo "but you are not using the built-in PCMCIA support."
			einfo "We will assume you know what you are doing, but please"
			einfo "consider using the built in PCMCIA support instead."
			epause 10
		fi

		ebegin "Decompressing pcmcia-cs sources"
		mkdir -p ${PCMCIA_SOURCE_DIR}
		tar -xjf ${pcmcia_tbz} -C ${PCMCIA_SOURCE_DIR}
		eend $?

		if [[ -f ${PCMCIA_SOURCE_DIR}/pcmcia-cs-version ]]; then
			PCMCIA_VERSION=$(cat ${PCMCIA_SOURCE_DIR}/pcmcia-cs-version)
			einfo "Found pcmcia-cs-${PCMCIA_VERSION}"
		fi
	fi
}

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is ge 2 6 15; then
		ewarn
		ewarn "Linux kernel 2.6.15 and above contains a more recent version of this"
		ewarn "module. Please consider using the in-kernel module when using"
		ewarn "linux-2.6.15 or above."
		ewarn
	fi

	if kernel_is ge 2 6 16; then
		ewarn
		ewarn "This version of hostap-driver is incompatible with linux-2.6.16 and above."
		ewarn "Please use the more recent in-kernel version of the hostap module when using"
		ewarn "linux-2.6.16 or above."
		ewarn
	fi

	MODULE_NAMES="hostap(net::${S}/driver/modules)
				hostap_pci(net::${S}/driver/modules)
				hostap_plx(net::${S}/driver/modules)
				hostap_crypt_wep(net::${S}/driver/modules)
				hostap_crypt_ccmp(net::${S}/driver/modules)
				hostap_crypt_tkip(net::${S}/driver/modules)"

	if use pcmcia; then
		MODULE_NAMES="${MODULE_NAMES} hostap_cs(net::${S}/driver/modules)"
	fi

	BUILD_PARAMS="KERNEL_PATH=${KV_DIR}"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-firmware.patch

	sed -i \
		-e "s:gcc:$(tc-getCC):" \
		-e "s:tail -1:tail -n 1:" \
		${S}/Makefile

	if use pcmcia; then
		# unpack the pcmcia-cs sources if needed
		pcmcia_src_unpack

		# set correct pcmcia path (PCMCIA_VERSION gets set from pcmcia_src_unpack)
		if [ -n "${PCMCIA_VERSION}" ]; then
			sed -i "s:^\(PCMCIA_PATH\)=:\1=${PCMCIA_SOURCE_DIR}:" ${S}/Makefile
		fi
	fi

	convert_to_m ${S}/Makefile
}

src_install() {
	if use pcmcia; then
		insinto /etc/pcmcia
		doins driver/etc/hostap_cs.conf
	fi

	dodoc ChangeLog

	linux-mod_src_install
}

pkg_postinst() {
	if [ -e /etc/pcmcia/prism2.conf ]
	then
		einfo ""
		einfo "You may need to edit or remove /etc/pcmcia/prism2.conf"
		einfo "This is usually a result of conflicts with the"
		einfo "net-wireless/linux-wlan-ng drivers."
		einfo ""
	fi

	ewarn ""
	ewarn "Please note that this installation of HostAP contains support"
	ewarn "for downloading binary firmware images into the non-volatile"
	ewarn "(permanent) flash memory of wireless LAN cards."
	ewarn ""
	ewarn "Albeit being a great feature, this can lead to A DEAD CARD"
	ewarn "when inappropriately used (e.g. wrong firmware)."
	ewarn ""

	linux-mod_pkg_postinst
}
