# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-VersionControl_SVN/PEAR-VersionControl_SVN-0.3.0_alpha1-r1.ebuild,v 1.19 2007/12/06 00:57:34 jokey Exp $

PEAR_PV="${PV/_/}"
inherit php-pear-r1

DESCRIPTION="Simple OO wrapper interface for the Subversion command-line client."
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-XML_Parser-1.2.7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:/usr/local:/usr:g' SVN.php || die "sed failed"
}
