# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopperl/dcopperl-3.5.10.ebuild,v 1.4 2009/07/06 18:07:43 ranger Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1

EAPI="1"
inherit kde-meta perl-app

DESCRIPTION="Perl bindings for DCOP"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

PATCHES=( "$FILESDIR/no-gtk-glib-check.diff"
	"$FILESDIR/installdirs-vendor.diff" ) # install into vendor_perl, not into site_perl - bug 42819

# Because this installs into /usr/lib/perl5/..., it doesn't have SLOT=X.Y like the rest of KDE,
# and it installs into /usr entirely
SLOT="0"

pm_echovar=" "

# Ugly, but necessary.
KDEDIRS="/usr/kde/3.5"

src_unpack(){
	kde-meta_src_unpack
}

src_compile() {
	S="${WORKDIR}/${P}/${PN}"
	cd "${S}"
	perl-module_src_prep
	sed -i -e "s:DESTDIR = :DESTDIR = ${D}:" Makefile
	perl-module_src_compile
	fixlocalpod
}

# note uses perl-module_pkg_postinst for more local.pod magic, was bug 83520
