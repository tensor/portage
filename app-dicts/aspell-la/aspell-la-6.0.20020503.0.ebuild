# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-la/aspell-la-6.0.20020503.0.ebuild,v 1.8 2009/03/02 13:04:37 pva Exp $

ASPELL_LANG="Latin"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

FILENAME="aspell6-la-20020503-0"
SRC_URI="mirror://gnu/aspell/dict/la/${FILENAME}.tar.bz2"
IUSE=""

S=${WORKDIR}/${FILENAME}
