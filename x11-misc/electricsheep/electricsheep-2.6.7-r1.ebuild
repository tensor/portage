# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/electricsheep/electricsheep-2.6.7-r1.ebuild,v 1.5 2007/07/22 04:04:00 dberkholz Exp $

inherit eutils flag-o-matic kde-functions

DESCRIPTION="realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="http://electricsheep.org/"
SRC_URI="http://electricsheep.org/${P}.tar.gz"
IUSE="kde"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"

RDEPEND="x11-libs/libXv
	x11-libs/libICE
	x11-libs/libSM
	dev-libs/expat
	net-misc/curl
	media-libs/jpeg
	>=media-libs/libpng-1.2.10
	media-libs/libsdl
	virtual/libc
	sys-libs/zlib"

DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-libs/libXt
	sys-apps/groff
	dev-lang/perl
	>=sys-apps/sed-4
	media-libs/libmpeg2
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	# Detect PIC requirement from direct from compiler instead of
	# macro PIC.
	sed -i -e 's/def PIC/def __PIC__/' ${S}/mpeg2dec/src/cpu_accel.c
	epatch ${FILESDIR}/${P}-cflagsfix.patch
	cd ${S}
	epatch ${FILESDIR}/${P}-libpng-1.2.10.patch
}

# Also detects and ties in sys-libs/slang, media-libs/aalib media-libs/svgalib and nas
# if they exist on the user machine although these aren't deps.

src_install() {

	# prevent writing for xscreensaver
	sed -i "s/^install-data-local:$/install-data-local:\nmy-install-data-local:/" \
		Makefile || die "sed Makefile failed"

	# install the xscreensaver config file
	insinto /usr/share/xscreensaver/config
	doins electricsheep.xml

	make install DESTDIR="${D}" || die "make install failed"

	dodir /usr/share/electricsheep
	if [ ! -f /usr/share/electricsheep/electricsheep-uniqueid ]
	then
		"${D}/usr/bin/uniqueid" > \
			"${D}/usr/share/electricsheep/electricsheep-uniqueid"
	fi

	if use kde;
	then
		set-kdedir
		insinto /usr/share/applications
		doins "${FILESDIR}/${PN}.desktop"
		insinto "${KDEDIR}//share/applnk/System/ScreenSavers"
		doins "${FILESDIR}/${PN}.desktop"
	fi

	# remove header files that are installed over libmpeg2
	rm -rf "${D}/usr/include"
}
