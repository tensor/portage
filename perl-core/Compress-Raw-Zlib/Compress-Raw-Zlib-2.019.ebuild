# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Raw-Zlib/Compress-Raw-Zlib-2.019.ebuild,v 1.1 2009/05/04 14:50:20 tove Exp $

MODULE_AUTHOR=PMQS

inherit multilib perl-module

DESCRIPTION="Low-Level Interface to zlib compression library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="dev-lang/perl
	>=sys-libs/zlib-1.2.2.1"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

src_unpack() {
	perl-module_src_unpack

	cat <<-EOF > "${S}/config.in"
		BUILD_ZLIB = False
		INCLUDE = /usr/include
		LIB = /usr/${get_libdir}

		OLD_ZLIB = False
		GZIP_OS_CODE = AUTO_DETECT
	EOF
}
