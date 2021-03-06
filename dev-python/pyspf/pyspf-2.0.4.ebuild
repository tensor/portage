# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyspf/pyspf-2.0.4.ebuild,v 1.1 2008/06/26 08:37:55 dragonheart Exp $

inherit distutils

DESCRIPTION="Python implementation of the Sender Policy Framework (SPF) protocol"
SRC_URI="mirror://sourceforge/pymilter/${P}.tar.gz"
HOMEPAGE="http://cheeseshop.python.org/pypi/pyspf"

IUSE=""
SLOT="0"
LICENSE="PSF-2.4"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pydns"
RDEPEND="dev-python/pydns"
