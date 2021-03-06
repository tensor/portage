# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/highline/highline-7.2.1.ebuild,v 1.5 2009/04/08 09:48:57 armin76 Exp $

inherit elisp

DESCRIPTION="Minor mode to highlight current line in buffer"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/HighlineMode"
# taken from: http://www.emacswiki.org/emacs/download/${PN}.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

SITEFILE="51${PN}-gentoo.el"

src_compile() {
	elisp-compile *.el || die
	elisp-make-autoload-file || die
}
