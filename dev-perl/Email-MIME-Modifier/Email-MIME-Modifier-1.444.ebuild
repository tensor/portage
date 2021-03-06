# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Modifier/Email-MIME-Modifier-1.444.ebuild,v 1.1 2009/05/01 10:55:43 tove Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Modify Email::MIME Objects Easily"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Email-MIME-1.857
	>=dev-perl/Email-MIME-Encodings-1.313
	>=dev-perl/Email-MessageID-1.35
	>=dev-perl/Email-MIME-ContentType-1.012
	dev-perl/Email-Simple"
RDEPEND="${DEPEND}"

SRC_TEST="do"
