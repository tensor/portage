# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-HMAC/Digest-HMAC-1.01-r1.ebuild,v 1.27 2008/08/22 21:28:24 aballier Exp $

inherit perl-module

DESCRIPTION="Keyed Hashing for Message Authentication"
HOMEPAGE="http://search.cpan.org/doc/GAAS/"
SRC_URI="mirror://cpan/authors/id/GAAS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/perl-digest-base
	virtual/perl-Digest-MD5
	dev-perl/Digest-SHA1
	dev-lang/perl"

SRC_TEST="do"

mydoc="rfc*.txt"
