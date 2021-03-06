# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.8_beta4-r3.ebuild,v 1.2 2009/07/13 15:06:21 josejx Exp $

inherit eutils autotools toolchain-funcs

MY_P="${PN}${PV/_beta/b}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk qt3"

RDEPEND="virtual/libc
	gtk? ( =x11-libs/gtk+-2* )
	qt3? ( =x11-libs/qt-3* )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch to fix broken autoconf macro "--with-qt-libs" needed below
	# Submitted upstream, hopefully fixed in a later version
	use qt3 && epatch "${FILESDIR}"/nvclock_acinclude_qtlibs.patch

	# Bug #240846:
	epatch "${FILESDIR}"/${P}-flags.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch

	sed -i Makefile.in -e "s:/share/doc/nvclock:/share/doc/${PF}:g" || \
		die "sed failed"

	eautoreconf
}

src_compile() {
	tc-export CC CXX
	# Needed to ensure it compiles against Qt3 rather than Qt4
	export QTDIR=/usr/qt/3
	export MOC=${QTDIR}/bin/moc

	local myconf

	myconf="--bindir=/usr/bin"

	# Qt3 package doesn't install symlinks from ${QTDIR}/lib64 to ${QTDIR}/lib
	use amd64 && myconf="${myconf} --with-qt-libs=${QTDIR}/lib64"

	econf $(use_enable qt3 qt) $(use_enable gtk) ${myconf} || die

	emake -j1 || die
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die
	#dodoc AUTHORS README

	newinitd "${FILESDIR}"/nvclock_initd nvclock
	newconfd "${FILESDIR}"/nvclock_confd nvclock

	#insinto /usr/share/applications
	#doins nvclock.desktop
	#validate_desktop_entries /usr/share/applications/nvclock.desktop
}

pkg_postinst() {
	elog "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	elog "accordingly and then run: rc-update add nvclock default"
}
