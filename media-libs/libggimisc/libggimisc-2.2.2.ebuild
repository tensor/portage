# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggimisc/libggimisc-2.2.2.ebuild,v 1.1 2008/01/10 19:44:48 drac Exp $

DESCRIPTION="Library for General Graphics Interface"
HOMEPAGE="http://www.ggi-project.org"
SRC_URI="mirror://sourceforge/ggi/${P}.src.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fbcon svga"

RDEPEND=">=media-libs/libggi-2.2.2
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}"

src_compile() {
	econf --disable-x --without-x \
		$(use_enable svga svgalib) \
		$(use_enable fbcon fbdev)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README TODO doc/*.txt
}

pkg_postinst() {
	elog "X extension for ${PN} has been temporarily disabled for this release."
}
