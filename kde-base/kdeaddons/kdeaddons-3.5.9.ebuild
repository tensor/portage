# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.5.9.ebuild,v 1.8 2008/05/18 21:45:52 maekke Exp $

EAPI="1"
inherit db-use kde-dist

DESCRIPTION="KDE addon modules: Plugins for Konqueror, Noatun,..."

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="arts berkdb sdl"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	arts? ( ~kde-base/arts-${PV} )
	sdl? ( >=media-libs/libsdl-1.2 )
	berkdb? ( =sys-libs/db-4* )
	!kde-misc/metabar"
RDEPEND="${DEPEND}"

pkg_setup() {
	kde_pkg_setup
	if use sdl && ! built_with_use media-libs/libsdl X ; then
		eerror "media-libs/libsdl is not build with X support."
		die "Please reemerge media-libs/libsdl with USE=\"X\"."
	fi
}

src_unpack() {
	einfo "NOTICE: If the compilation dies complaining with"
	einfo "\"SDL - version >= 1.2.0... no\", please run"
	einfo "\"emerge --oneshot media-libs/libsdl\" and retry."
	kde_src_unpack
}

src_compile() {
	local myconf="$(use_with sdl)
				--without-xmms"

	if use berkdb; then
		dblib="$(db_libname)"
		myconf="${myconf}
				--with-berkeley-db
				--with-db-lib=${dblib/-/_cxx-}
				--with-extra-includes=$(db_includedir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	# Parallel make breaks this package.
	MAKEOPTS="${MAKEOPTS} -j1"

	kde_src_compile
}
