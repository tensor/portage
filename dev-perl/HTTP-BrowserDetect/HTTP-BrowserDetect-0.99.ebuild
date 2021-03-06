# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-0.99.ebuild,v 1.5 2008/03/28 08:58:38 jer Exp $

inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"
SRC_URI="mirror://cpan/authors/id/W/WA/WALSHAM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~walsham/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
