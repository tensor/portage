# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font-otf/mikachan-font-otf-9.1-r1.ebuild,v 1.1 2009/02/21 13:49:00 lu_zero Exp $

inherit font

DESCRIPTION="Mikachan Japanese TrueType Collection fonts"
HOMEPAGE="http://mikachan-font.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~flameeyes/dist/${P}.tar.bz2"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="otf"
FONT_S="${WORKDIR}/${P}"

# Only installs fonts
RESTRICT="strip binchecks"

FONT_CONF=( "${FILESDIR}/60-mikachan_o.conf" )

pkg_postinst() {
	font_pkg_postinst

	echo
	elog "To use mikachan otf instead of the default font for sans, serif and"
	elog "monospace, use:"
	elog "   eselect fontconfig enable 60-mikachan_o.conf"
	echo
}
