# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.7.2.ebuild,v 1.8 2009/07/01 09:23:40 jer Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod.html"
SRC_URI="mirror://sourceforge/gtkpod/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ppc ~ppc64 sparc x86"
IUSE="+gtk python test hal"

RDEPEND=">=dev-libs/glib-2.16
	sys-apps/sg3_utils
	dev-libs/libxml2
	hal? ( =sys-apps/hal-0.5* )
	gtk? ( >=x11-libs/gtk+-2.6 )
	python? ( >=dev-lang/python-2.3
		>=media-libs/mutagen-1.8
		>=dev-python/pygobject-2.8 )
	test? ( media-libs/taglib )"
DEPEND="${RDEPEND}
	python? ( >=dev-lang/swig-1.3.24 )
	dev-util/pkgconfig
	dev-libs/libxslt"

src_prepare() {
	epatch "${FILESDIR}/${P}-compile-without-hal.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_with hal) \
		$(use_enable gtk gdk-pixbuf) \
		$(use_enable python pygobject) \
		$(use_with python) || die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README TROUBLESHOOTING AUTHORS NEWS README.SysInfo
}
