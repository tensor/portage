# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mu-cite/mu-cite-8.1_p20070903.ebuild,v 1.1 2007/09/23 18:20:16 ulm Exp $

inherit elisp

MY_P="${PN}-${PV#*p}0413"
DESCRIPTION="Message citation utilities for emacsen"
HOMEPAGE="http://www.jpl.org/elips/mu/"
SRC_URI="http://www.jpl.org/elips/mu/snapshots/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-emacs/apel
	virtual/flim"

SITEFILE=50${PN}-gentoo.el
DOCS="ChangeLog NEWS README.en"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake EMACS=emacs || die "emake failed"
}
