# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Element-Extended/HTML-Element-Extended-1.16.ebuild,v 1.7 2006/10/09 15:11:09 mcummings Exp $

inherit perl-module

DESCRIPTION="Extension for manipulating a table composed of HTML::Element style components."
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/M/MS/MSISK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/HTML-Tree-3.01
	dev-lang/perl"
