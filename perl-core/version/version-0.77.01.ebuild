# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/version/version-0.77.01.ebuild,v 1.1 2009/08/04 16:06:31 tove Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2 )
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=JPEACOCK
inherit perl-module

DESCRIPTION="Perl extension for Version Objects"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.33.05"

SRC_TEST="do"
myconf="--extra_linker_flags="${LDFLAGS}""
