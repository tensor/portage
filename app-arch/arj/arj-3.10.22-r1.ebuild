# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arj/arj-3.10.22-r1.ebuild,v 1.9 2007/07/02 13:37:27 peper Exp $

WANT_AUTOCONF="latest"

inherit eutils toolchain-funcs autotools

DESCRIPTION="Utility for opening arj archives"
HOMEPAGE="http://arj.sourceforge.net/"
SRC_URI="mirror://sourceforge/arj/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="strip"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/001_arches_align.patch"
	epatch "${FILESDIR}/002_no_remove_static_const.patch"
	epatch "${FILESDIR}/003_64_bit_clean.patch"

	cd "${S}/gnu"
	eautoreconf
}

src_compile() {
	if [ -x /usr/sbin/gcc-config ]
	then
		# Do we have a gcc that use the new layout and gcc-config ?
		if /usr/sbin/gcc-config --get-current-profile &> /dev/null
		then
			export GCC_PROFILE="$(/usr/sbin/gcc-config --get-current-profile)"

			# Just recheck gcc version ...
			if [ "$(gcc-version)" != "3.2" ] && [ "$(gcc-version)" != "3.3" ]
			then
				# See if we can get a gcc profile we know is proper ...
				if /usr/sbin/gcc-config --get-bin-path ${CHOST}-3.3.4 &> /dev/null
				then
					export PATH="$(/usr/sbin/gcc-config --get-bin-path ${CHOST}-3.3.4):${PATH}"
					export GCC_PROFILE="${CHOST}-3.3.4"
				else
					eerror "This build needs gcc-3.2 or gcc-3.3!"
					eerror
					eerror "Use gcc-config to change your gcc profile:"
					eerror
					eerror "  # gcc-config $CHOST-3.3.4"
					eerror
					eerror "or whatever gcc version is relevant."
					die
				fi
			fi
		fi
	fi

	cd "${S}/gnu"
	econf || die

	cd "${S}"
	make prepare || die "make prepare failed"
	make package || die "make package failed"
}

src_install() {
	cd "${S}/${CHOST#*-*-}/en/rs/u"
	dobin bin/* || die
	dodoc doc/arj/* "${S}/ChangeLog"
}
