# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Sendmail/Mail-Sendmail-0.79.ebuild,v 1.19 2007/07/10 23:33:33 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Simple platform independent mailer"
SRC_URI="mirror://cpan/authors/id/M/MI/MIVKOVIC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Mail-Sendmail/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
