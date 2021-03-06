# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.10.0c-r2.ebuild,v 1.1 2009/05/28 12:44:48 scarabeus Exp $

EAPI="2"

ARTS_REQUIRED="never"

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend for KDE."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://kmplayer.kde.org/pkgs/${MY_P}.tar.bz2"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="mplayer xine cairo gstreamer npp"

DEPEND="x11-libs/libXv
	>=dev-libs/expat-2.0.1
	xine? ( >=media-libs/xine-lib-1.1.1 )
	cairo? ( x11-libs/cairo[X] )
	gstreamer? ( >=media-libs/gstreamer-0.10.11
		npp? ( >=sys-apps/dbus-1.0.2-r2
			>=dev-libs/dbus-glib-0.73
			>=dev-libs/dbus-qt3-old-0.70 ) )
	npp? ( >=dev-libs/nspr-4.6.7
			>=x11-libs/gtk+-2.10.14 )"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:0
	mplayer? ( media-video/mplayer )"

LANGS="ar be br bs ca csb cs cy da de el en_GB es et fi fr ga gl he hi hu is it
ja ka lt mt nb nl nn pa pl pt_BR pt ro ru rw sk sr@Latn sr sv ta tr uk zh_CN"
LANGS_DOC="da de en es et fr it nl pt ru sv"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

need-kde 3.5

PATCHES=(
	"${FILESDIR}/${PN}-0.10.0-prtypes.patch"
	"${FILESDIR}/kmplayer-0.10.0c-desktop-file.diff"
	)

pkg_setup() {
	kde_pkg_setup

	if ! use mplayer && ! use xine && ! use cairo && ! use gstreamer ; then
		echo
		ewarn "Neither the mplayer, xine, cairo nor gstreamer USE flags have been set. One of"
		ewarn "them is required. mplayer can be installed afterwards; all of the others will"
		ewarn "require you to recompile ${PN}."
	fi
}

src_unpack() {
	kde_src_unpack

	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}.po"
	done
	cd "${S}/po"
	sed -i -e "s:POFILES =.*:POFILES = ${MAKE_LANGS}:" Makefile.am

	MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | tr ' ' '\n' | sort | uniq -d))
	[[ -n ${MAKE_DOC} ]] && [[ -n ${DOC_DIR_SUFFIX} ]] && \
		MAKE_DOC=$(echo "${MAKE_DOC}" | tr '\n' ' ') && \
		MAKE_DOC="${MAKE_DOC// /${DOC_DIR_SUFFIX} }"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = en ${MAKE_DOC}:" \
		"${KDE_S}/doc/Makefile.am" || die "sed for locale failed"

	rm -f "${S}/configure"
}

src_configure() {
	local myconf="--enable-expat
				$(use_with gstreamer)
				$(use_with xine)
				$(use_with cairo)
				--disable-koffice-plugin
				$(use_enable npp nspr)
				$(use_enable npp npplayer)"

	# The configure script is a bloated mess and won't work correctly without this.
	PKG_CONFIG="pkg-config"	kde_src_configure
}

src_install() {
	kde_src_install

	# Remove this, as kdelibs provides it
	rm -f "${D}/${KDEDIR}/share/mimelnk/application/x-mplayer2.desktop"
}
