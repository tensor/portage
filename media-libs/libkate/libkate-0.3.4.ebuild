# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkate/libkate-0.3.4.ebuild,v 1.2 2009/07/22 18:06:52 solar Exp $

DESCRIPTION="Codec for karaoke and text encapsulation for Ogg"
HOMEPAGE="http://code.google.com/p/libkate/"
SRC_URI="http://libkate.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc wxwindows"

COMMON_DEPEND="media-libs/libogg
	media-libs/libpng"
DEPEND="${COMMON_DEPEND}
	wxwindows? ( dev-lang/python )
	dev-util/pkgconfig
	sys-devel/flex
	sys-devel/bison
	doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}
	wxwindows? ( =dev-python/wxpython-2.8* media-libs/liboggz )"

src_compile() {
	use wxwindows || sed -i -e "s/HAVE_PYTHON=yes/HAVE_PYTHON=no/" configure
	econf $(use_enable doc) --docdir=/usr/share/doc/${PF}
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
