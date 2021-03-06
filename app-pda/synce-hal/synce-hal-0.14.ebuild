# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-hal/synce-hal-0.14.ebuild,v 1.1 2009/08/06 12:29:52 mescalinum Exp $

inherit multilib versionator

DESCRIPTION="SynCE - hal connection manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

synce_PV=$(get_version_component_range 1-2)

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-apps/hal
		>=net-libs/gnet-2.0.0
		!app-pda/synce-dccm
		!app-pda/synce-vdccm
		!app-pda/synce-odccm
		=app-pda/synce-libsynce-${synce_PV}*
		=app-pda/synce-librapi2-${synce_PV}*
		=app-pda/synce-librra-${synce_PV}*"
RDEPEND="${DEPEND}
		=app-pda/synce-sync-engine-${synce_PV}*
		app-pda/synce-serial
		net-misc/dhcp"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_compile() {
	if has_version '>=sys-apps/hal-0.5.13'; then
		HAL_ADDON_DIR="/usr/libexec/scripts"
	else
		HAL_ADDON_DIR="/usr/$(get_libdir)/hal/scripts"
	fi
	econf --with-hal-addon-dir="${HAL_ADDON_DIR}" --localstatedir="/var" || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README ChangeLog || die

	# fix collision with app-pda/synce-serial, bug 246675
	rm -f "${D}/usr/libexec/synce-serial-chat"
}
