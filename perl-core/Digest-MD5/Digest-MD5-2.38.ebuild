# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Digest-MD5/Digest-MD5-2.38.ebuild,v 1.4 2009/03/19 14:35:48 armin76 Exp $

MODULE_AUTHOR=GAAS
inherit perl-module

DESCRIPTION="MD5 message digest algorithm"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
		virtual/perl-digest-base"

mydoc="rfc*.txt"
