# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Spec/File-Spec-3.25.ebuild,v 1.10 2008/11/18 14:18:11 tove Exp $

inherit perl-module

MY_P="PathTools-${PV}"

DESCRIPTION="Handling files and directories portably"
HOMEPAGE="http://search.cpan.org/~kwilliams/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/perl-ExtUtils-CBuilder"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

S=${WORKDIR}/${MY_P}

myconf='INSTALLDIRS=vendor'
