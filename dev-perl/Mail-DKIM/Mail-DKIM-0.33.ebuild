# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.33.ebuild,v 1.1 2009/03/12 17:56:21 tove Exp $

EAPI=2

MODULE_AUTHOR=JASLONG
inherit perl-module

DESCRIPTION="Mail::DKIM - Signs/verifies Internet mail using DKIM message signatures"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Crypt-OpenSSL-RSA-0.24
		virtual/perl-Digest-SHA
		virtual/perl-MIME-Base64
		dev-perl/Net-DNS
		dev-perl/MailTools"
RDEPEND="${DEPEND}"

SRC_TEST="do"

src_test(){
	# disable online tests
	for test in policy verifier ; do
		mv "${S}"/t/${test}.t{,.disable}
	done
	perl-module_src_test
}
