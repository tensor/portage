# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font-ttf/mikachan-font-ttf-8.9-r2.ebuild,v 1.1 2009/02/21 13:38:18 lu_zero Exp $

inherit font

MY_PN="mikachanfont"

DESCRIPTION="Mikachan Japanese TrueType fonts"
HOMEPAGE="http://mikachan-font.com/"
SRC_URI="mirror://sourceforge.jp/mikachan/5513/${MY_PN}-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5514/${MY_PN}P-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5515/${MY_PN}PB-${PV}.tar.bz2
	mirror://sourceforge.jp/mikachan/5516/${MY_PN}PS-${PV}.tar.bz2"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

# Only installs fonts
RESTRICT="strip binchecks"
FONT_CONF=( "${FILESDIR}/60-mikachan.conf" )

src_install() {
	insinto /usr/share/fonts/${PN}

	for f in "${MY_PN}" "${MY_PN}P" "${MY_PN}PB" "${MY_PN}PS" ; do
		cd "${WORKDIR}/${f}-${PV}"
		doins fonts/*.ttf
		newdoc README README.${f}
		newdoc README.ja README.ja.${f}
		newdoc ChangeLog ChangeLog.${f}
	done

	font_xfont_config
	font_xft_config
	font_fontconfig
}

pkg_postinst() {
	font_pkg_postinst

	echo
	elog "To use mikachan ttf instead of the default font for sans, serif and"
	elog "monospace, use:"
	elog "   eselect fontconfig enable 60-mikachan.conf"
	echo
}
