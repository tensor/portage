# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-base/gst-plugins-base-0.10.22.ebuild,v 1.10 2009/08/10 02:13:13 leio Exp $

# order is important, gnome2 after gst-plugins
inherit gst-plugins-base gst-plugins10 gnome2 flag-o-matic eutils

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.12
	>=media-libs/gstreamer-0.10.22
	>=dev-libs/liboil-0.3.14
	!<media-libs/gst-plugins-bad-0.10.10"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.5 )
	dev-util/pkgconfig"

DOCS="AUTHORS README RELEASE"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-CVE-2009-0586.patch
	elibtoolize
}

src_compile() {
	# GStreamer doesn't handle optimization.
	strip-flags
	replace-flags -O3 -O2

	gst-plugins-base_src_configure \
		$(use_enable nls)

	emake || die "emake failed"
}

src_install() {
	gnome2_src_install
}
