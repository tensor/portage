# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kflickr/kflickr-0.9.1-r1.ebuild,v 1.1 2009/02/10 23:57:10 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Kflickr is a KDE application for easy upload of your favourite photos to your Flickr.com account."
HOMEPAGE="http://kflickr.sourceforge.net/"
SRC_URI="mirror://sourceforge/kflickr/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.5

PATCHES=( "${FILESDIR}/kflickr-0.9.1-desktop-file.diff" )

LANGS="ar ca de es fr he it ko nb nds nl pl pt_BR ru sl sv zh_CN"

for lang in ${LANGS} ${LANGS_DOC}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_unpack() {
	kde_src_unpack

	if [[ -z ${LINGUAS} ]]; then
		einfo "You can drop some of the translations of the interface and"
		einfo "documentation by setting the \${LINGUAS} variable to the"
		einfo "languages you want installed."
		einfo
		einfo "Enabling all languages"
	else
		cd "${S}/po"
		for X in ${LANGS} ; do
			use linguas_${X} || rm -f "${X}."*
		done
		rm -f "${S}/configure"
	fi
}
