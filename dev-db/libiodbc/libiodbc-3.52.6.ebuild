# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libiodbc/libiodbc-3.52.6.ebuild,v 1.8 2008/01/10 09:58:08 vapier Exp $

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

DESCRIPTION="ODBC Interface for Linux."
HOMEPAGE="http://www.iodbc.org/"
SRC_URI="http://www.iodbc.org/downloads/iODBC/${P}.tar.gz"
LICENSE="|| ( LGPL-2 BSD )"
SLOT="0"
IUSE="gtk"

DEPEND=">=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-2* )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i.orig \
		-e '/^cd "$PREFIX"/,/^esac/d' \
		iodbc/install_libodbc.sh || die "sed failed"
}

src_compile() {
	econf \
		--with-layout=gentoo \
		$(use_enable gtk gui) \
		|| die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
