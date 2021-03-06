# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey-bin/seamonkey-bin-2.0_alpha3.ebuild,v 1.1 2009/03/06 16:55:36 armin76 Exp $

inherit eutils mozilla-launcher multilib

MY_PV="${PV/_alpha/a}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/seamonkey/releases/${MY_PV}/seamonkey-${MY_PV}.en-US.linux-i686.tar.bz2"
HOMEPAGE="http://www.seamonkey-project.org/"
RESTRICT="strip"
QA_EXECSTACK="opt/seamonkey/*"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/dbus-glib
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	x86? (
		>=x11-libs/gtk+-2.2
		>=media-libs/alsa-lib-1.0.16
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
		>=app-emulation/emul-linux-x86-soundlibs-20080418
		app-emulation/emul-linux-x86-compat
	)"

S="${WORKDIR}/seamonkey"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/seamonkey

	# Install seamonkey in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}${MOZILLA_FIVE_HOME}"

	# Create /usr/bin/seamonkey-bin
	dodir /usr/bin/
	cat <<EOF >"${D}"/usr/bin/seamonkey-bin
#!/bin/sh
unset LD_PRELOAD
exec /opt/seamonkey/seamonkey "\$@"
EOF
	fperms 0755 /usr/bin/seamonkey-bin

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}/icon/${PN}.png"
	domenu "${FILESDIR}/icon/${PN}.desktop"
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/seamonkey

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${ROOT}${MOZILLA_FIVE_HOME}"
}

pkg_postinst() {
	use amd64 && einfo "NB: You just installed a 32-bit seamonkey"
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
