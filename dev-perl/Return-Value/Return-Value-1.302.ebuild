# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Return-Value/Return-Value-1.302.ebuild,v 1.13 2007/12/08 12:04:57 armin76 Exp $

inherit perl-module

DESCRIPTION="Polymorphic Return Values"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

DEPEND="virtual/perl-Test-Simple
	dev-lang/perl"

SRC_TEST="do"
