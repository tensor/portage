# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-1.003-r1.ebuild,v 1.6 2009/08/10 19:58:39 tove Exp $

inherit versionator
MODULE_AUTHOR=RCAPUTO
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="A framework for creating multitasking programs in Perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="ipv6 libwww ncurses tk"

DEPEND="dev-lang/perl
	>=dev-perl/Event-1.09
	>=virtual/perl-File-Spec-0.87
	>=virtual/perl-IO-1.23.01
	>=virtual/perl-IO-Compress-1.33
	>=virtual/perl-Storable-2.12
	>=dev-perl/IO-Tty-1.02
	virtual/perl-Filter
	>=virtual/perl-Test-Harness-2.26
	dev-perl/FreezeThaw
	dev-perl/yaml
	>=virtual/perl-Test-Simple-0.54
	>=dev-perl/TermReadKey-2.21
	>=virtual/perl-Time-HiRes-1.59
	ipv6? ( >=dev-perl/Socket6-0.14 )
	tk? ( >=dev-perl/perl-tk-800.027 )
	libwww? ( >=dev-perl/libwww-perl-5.79
		>=dev-perl/URI-1.30 )
	ncurses? ( >=dev-perl/Curses-1.08 )"

# seems to break things - Patrick
#mymake="/usr"
