# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Test/perl-Test-1.25.ebuild,v 1.4 2007/07/11 05:04:22 mr_bones_ Exp $

DESCRIPTION="Virtual for Test"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"

IUSE=""
DEPEND=""
RDEPEND="|| ( >=dev-lang/perl-5.8.8 ~perl-core/Test-${PV} )"
