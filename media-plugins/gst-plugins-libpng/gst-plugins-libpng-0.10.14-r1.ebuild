# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.14-r1.ebuild,v 1.7 2009/07/01 16:54:32 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode png images"
KEYWORDS="alpha amd64 ~arm ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"

src_unpack ()
{
	gst-plugins-good_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/gst-plugins-good-0.10.15-CVE-2009-1932.patch"
}
