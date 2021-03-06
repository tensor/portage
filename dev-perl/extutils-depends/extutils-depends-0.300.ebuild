# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-depends/extutils-depends-0.300.ebuild,v 1.11 2009/06/22 16:41:54 armin76 Exp $

inherit perl-module

MY_P=ExtUtils-Depends-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Easily build XS extensions that depend on XS extensions"
HOMEPAGE="http://search.cpan.org/~tsch/ExtUtils-Depends/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
