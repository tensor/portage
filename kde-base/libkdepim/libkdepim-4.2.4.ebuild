# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdepim/libkdepim-4.2.4.ebuild,v 1.2 2009/06/05 07:36:26 alexxy Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Common library for KDE PIM apps"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	>=kde-base/kode-${PV}:${SLOT}[kdeprefix=]
"

KMEXTRACTONLY="
	kaddressbook/org.kde.KAddressbook.Core.xml
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
"

KMSAVELIBS="true"

src_install() {
	kde4-meta_src_install

	# install additional generated headers that are needed by other packages that
	# are derived from kdepim. e.g. kmail.
	pushd "${CMAKE_BUILD_DIR}/libkdepim/" 2>/dev/null || die "pushd libkdepim failed"
	insinto "${PREFIX}/include"
	doins ui_addresspicker.h ui_categoryselectdialog_base.h || die "Failed to install extra header files."
	popd 2>/dev/null
}
