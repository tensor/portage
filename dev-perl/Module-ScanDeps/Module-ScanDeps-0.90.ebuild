# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-0.90.ebuild,v 1.2 2009/06/23 14:00:57 tove Exp $

EAPI=2

MODULE_AUTHOR=SMUELLER
inherit perl-module

DESCRIPTION="Recursively scan Perl code for dependencies"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Module-Build
	virtual/perl-version"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/prefork
		virtual/perl-Module-Pluggable )"

SRC_TEST=do
