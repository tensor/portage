# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-test/qt-test-4.5.1.ebuild,v 1.8 2009/06/30 15:10:29 armin76 Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The testing framework module for the Qt toolkit"
SLOT="4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="+iconv"

DEPEND="~x11-libs/qt-core-${PV}[debug=]"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="src/testlib"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
include/QtTest/
include/QtCore/
src/corelib/"

src_configure() {
	myconf="${myconf} $(qt_use iconv) -no-xkb  -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-dbus -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -no-openssl -system-zlib -no-webkit -no-phonon
		-no-qt3support -no-xmlpatterns -no-freetype -no-libtiff -no-accessibility
		-no-fontconfig -no-glib -no-opengl -no-svg"
	qt4-build_src_configure
}
