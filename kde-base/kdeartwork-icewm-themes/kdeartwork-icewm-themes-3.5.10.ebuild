# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-icewm-themes/kdeartwork-icewm-themes-3.5.10.ebuild,v 1.7 2009/07/12 12:25:03 armin76 Exp $

RESTRICT="binchecks strip"

KMMODULE=icewm-themes
KMNAME=kdeartwork
EAPI="1"
inherit kde-meta

DESCRIPTION="Themes for IceWM from the kdeartwork package."
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND=">=kde-base/kdeartwork-kwin-styles-${PV}:${SLOT}"

pkg_postinst() {
	kde_pkg_postinst
	elog "More IceWM themes are available installing x11-themes/icewm-themes"
}
