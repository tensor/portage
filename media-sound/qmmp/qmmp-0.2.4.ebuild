# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmmp/qmmp-0.2.4.ebuild,v 1.4 2009/07/26 15:21:48 ssuominen Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Qt4-based audio player with winamp/xmms skins support"
HOMEPAGE="http://qmmp.ylsoftware.com/index_en.php"
SRC_URI="http://qmmp.ylsoftware.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+alsa +dbus ffmpeg flac jack libsamplerate +mad modplug musepack oss
	pulseaudio scrobbler sndfile +vorbis wavpack"

RDEPEND="x11-libs/qt-gui:4
	media-libs/taglib
	alsa? ( media-libs/alsa-lib )
	dbus? ( sys-apps/dbus )
	flac? ( media-libs/flac )
	libsamplerate? ( media-libs/libsamplerate )
	mad? ( media-libs/libmad )
	musepack? ( >=media-libs/libmpcdec-1.2.5 )
	modplug? ( >=media-libs/libmodplug-0.8.4 )
	vorbis? ( media-libs/libvorbis
		media-libs/libogg )
	jack? ( media-sound/jack-audio-connection-kit
		media-libs/libsamplerate )
	ffmpeg? ( media-video/ffmpeg )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.9 )
	wavpack? ( media-sound/wavpack )
	scrobbler? ( net-misc/curl )
	sndfile? ( media-libs/libsndfile )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog README"

PATCHES=(
	"${FILESDIR}/decoder_mad-gcc-4.3.patch"
)

qmmp_use_enable() {
	# uses completely non standard cmake options...
	if use ${1}; then
		echo "-DUSE_${2}:BOOL=TRUE"
	else
		echo "-DUSE_${2}:BOOL=FALSE"
	fi
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(qmmp_use_enable alsa ALSA)
		$(qmmp_use_enable dbus DBUS)
		$(qmmp_use_enable ffmpeg FFMPEG)
		$(qmmp_use_enable flac FLAC)
		$(qmmp_use_enable jack JACK)
		$(qmmp_use_enable mad MAD)
		$(qmmp_use_enable modplug MODPLUG)
		$(qmmp_use_enable musepack MPC)
		$(qmmp_use_enable oss OSS)
		$(qmmp_use_enable pulseaudio PULSE)
		$(qmmp_use_enable scrobbler SCROBBLER)
		$(qmmp_use_enable sndfile SNDFILE)
		$(qmmp_use_enable libsamplerate SRC)
		$(qmmp_use_enable vorbis VORBIS)
		$(qmmp_use_enable wavpack WAVPACK)"

	cmake-utils_src_compile
}
