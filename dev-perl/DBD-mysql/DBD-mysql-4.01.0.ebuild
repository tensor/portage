# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-4.01.0.ebuild,v 1.1 2008/12/08 02:11:54 robbat2 Exp $

inherit versionator

MODULE_AUTHOR="CAPTTOFU"
MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
inherit eutils perl-module

S=${WORKDIR}/${MY_P}

DESCRIPTION="The Perl DBD:mysql Module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/DBI
	virtual/mysql"

mydoc="ToDo"
