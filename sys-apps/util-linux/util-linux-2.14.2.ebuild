# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.14.2.ebuild,v 1.12 2009/07/26 20:41:50 zmedico Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git"
inherit eutils autotools
[[ ${PV} == "9999" ]] && inherit git autotools

MY_PV=${PV/_/-}
MY_P=${PN}-ng-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux-ng/"
if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
else
	SRC_URI="mirror://kernel/linux/utils/util-linux-ng/v${PV:0:4}/${MY_P}.tar.bz2
		loop-aes? ( http://loop-aes.sourceforge.net/updates/util-linux-ng-2.14.2-20090214.diff.bz2 )"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="crypt loop-aes nls old-linux selinux slang uclibc unicode"

RDEPEND="!sys-process/schedutils
	!sys-apps/setarch
	>=sys-libs/ncurses-5.2-r2
	>=sys-libs/e2fsprogs-libs-1.41
	selinux? ( sys-libs/libselinux )
	slang? ( sys-libs/slang )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/os-headers"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git_src_unpack
		cd "${S}"
		eautoreconf
	else
		unpack ${A}
		cd "${S}"
		#epatch "${FILESDIR}"/${PN}-2.13-uclibc.patch #203711
		epatch "${FILESDIR}"/${PN}-2.15-old-libselinux.patch #270168
		use loop-aes && epatch "${WORKDIR}"/util-linux-ng-*.diff
		eautoreconf
	fi
	if use uclibc ; then
		sed -i -e s/versionsort/alphasort/g -e s/strverscmp.h/dirent.h/g mount/lomount.c
		sed -i -e 's/program_invocation_short_name/"scriptreplay"/' misc-utils/scriptreplay.c
		sed -i -e 's/program_invocation_short_name/"setarch"/' sys-utils/setarch.c
		sed -i -e 's/program_invocation_short_name/"ldattach"/' sys-utils/ldattach.c
		sed -i -e 's:test = SYS_sched_getaffinity:LSDJFLSKDF = asdfasdf:' configure
	fi
}

src_compile() {
	econf \
		--with-fsprobe=blkid \
		$(use_enable nls) \
		--enable-agetty \
		--enable-cramfs \
		$(use_enable old-linux elvtune) \
		--disable-init \
		--disable-kill \
		--disable-last \
		--disable-mesg \
		--enable-partx \
		--enable-raw \
		--enable-rdev \
		--enable-rename \
		--disable-reset \
		--disable-login-utils \
		--enable-schedutils \
		--disable-wall \
		--enable-write \
		--without-pam \
		$(use unicode || echo --with-ncurses) \
		$(use_with selinux) \
		$(use_with slang) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS NEWS README* TODO docs/*

	if use crypt ; then
		newinitd "${FILESDIR}"/crypto-loop.initd crypto-loop || die
		newconfd "${FILESDIR}"/crypto-loop.confd crypto-loop || die
	fi
}

pkg_postinst() {
	ewarn "The loop-aes code has been split out of USE=crypt and into USE=loop-aes."
	ewarn "If you need support for it, make sure to update your USE accordingly."
}
