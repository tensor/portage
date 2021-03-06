# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdm/kdm-3.5.10.ebuild,v 1.7 2009/07/12 13:40:51 armin76 Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="KDE login manager, similar to xdm and gdm"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="elibc_glibc kdehiddenvisibility pam"

KMEXTRA="kdmlib/"
KMEXTRACTONLY="libkonq/konq_defaults.h"
KMCOMPILEONLY="kcontrol/background"

DEPEND="pam? ( kde-base/kdebase-pam )
	x11-libs/libXau
	x11-libs/libXtst
	>=kde-base/kcontrol-${PV}:${SLOT}"
	# Requires the desktop background settings and kdm kcontrol modules
RDEPEND="${DEPEND}
	>=kde-base/kdepasswd-${PV}:${SLOT}
	x11-apps/xinit
	x11-apps/xmessage"
PDEPEND=">=kde-base/kdesktop-${PV}:${SLOT}"

src_compile() {
	local myconf="--with-x-binaries-dir=/usr/bin $(use_with pam)"

	if ! use pam && use elibc_glibc; then
		myconf="${myconf} --with-shadow"
	fi

	export USER_LDFLAGS="${LDFLAGS}"

	kde-meta_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde-meta_src_compile make
}

src_install() {
	kde-meta_src_install
	cd "${S}/kdm" && make DESTDIR="${D}" GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${KDEDIR}/share/config/kdm/kdmrc" || die
}

pkg_postinst() {
	kde_pkg_postinst

	# set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ];	then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi
}
