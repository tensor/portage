# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-VersionControl_SVN/PEAR-VersionControl_SVN-0.3.1.ebuild,v 1.8 2008/03/29 00:25:14 maekke Exp $

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
