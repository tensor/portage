# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bongo/bongo-20070619-r2.ebuild,v 1.1 2009/07/05 09:29:26 ulm Exp $

NEED_EMACS=22

inherit elisp eutils

DESCRIPTION="Buffer-oriented media player for Emacs"
HOMEPAGE="http://www.brockman.se/software/bongo/"
# Darcs snapshot of http://www.brockman.se/software/bongo/
# MPlayer support from http://www.emacswiki.org/emacs/bongo-mplayer.el
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mplayer? ( mirror://gentoo/${PN}-mplayer-${PV}.tar.bz2 )"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mplayer taglib"

# NOTE: Bongo can use almost anything for playing media files, therefore
# the dependency possibilities are so broad that we refrain from including
# any media players explicitly in DEPEND/RDEPEND.

DEPEND="app-emacs/volume"
RDEPEND="${DEPEND}
	taglib? ( dev-ruby/ruby-taglib )"

S="${WORKDIR}/${PN}"
DOCS="NEWS README"
SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We need Emacs 22 for image-load-path anyway, so don't bother with 21.
	rm -f bongo-emacs21.el

	epatch "${FILESDIR}/${P}-fix-require.patch"
}

src_compile() {
	elisp_src_compile
	makeinfo bongo.texinfo || die "makeinfo failed"
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins *.pbm *.png || die "doins failed"

	if use taglib; then
		dobin tree-from-tags.rb || die "dobin failed"
	fi

	doinfo bongo.info || die "doinfo failed"
}
