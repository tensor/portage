# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nn/myspell-nn-20060530.ebuild,v 1.4 2008/02/09 19:00:03 armin76 Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nn,NO,nn_NO,Norwegian nynorsk (Norway),nn_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"nn,NO,hyph_nn_NO,Norwegian nynorsk (Norway),hyph_nn_NO.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"nn,NO,th_nn_NO_v1,Norwegian nynorsk (Norway),th_nn_NO_v1.zip"
)

inherit myspell

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://spell-norwegian.alioth.debian.org/"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
