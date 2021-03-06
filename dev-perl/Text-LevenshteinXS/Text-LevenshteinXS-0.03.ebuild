# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-LevenshteinXS/Text-LevenshteinXS-0.03.ebuild,v 1.10 2007/07/10 23:33:27 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="An XS implementation of the Levenshtein edit distance"
HOMEPAGE="http://search.cpan.org/~jgoldberg/"
SRC_URI="mirror://cpan/authors/id/J/JG/JGOLDBERG/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
