# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon/Net-Amazon-0.55.ebuild,v 1.1 2009/07/22 08:30:03 tove Exp $

EAPI=2

MODULE_AUTHOR=BOUMENOT
inherit perl-module

DESCRIPTION="Net::Amazon - Framework for accessing amazon.com via SOAP and XML/HTTP"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Simple-2.08
	>=virtual/perl-Time-HiRes-1.0
	>=dev-perl/Log-Log4perl-0.3
	virtual/perl-Digest-SHA
	dev-perl/URI"
RDEPEND="${DEPEND}"

SRC_TEST="do"
