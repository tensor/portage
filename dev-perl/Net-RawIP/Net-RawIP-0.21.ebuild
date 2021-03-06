# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-RawIP/Net-RawIP-0.21.ebuild,v 1.6 2008/03/28 09:03:16 jer Exp $

inherit eutils perl-module

IUSE=""
DESCRIPTION="Perl Net::RawIP - Raw IP packets manipulation Module"
SRC_URI="mirror://cpan/authors/id/S/SZ/SZABGAB/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~szabgab/"

DEPEND="net-libs/libpcap
	>=sys-apps/sed-4
	dev-lang/perl"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
