# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-2.0.ebuild,v 1.7 2009/05/05 07:48:02 ssuominen Exp $

inherit virtualx eutils

DESCRIPTION="GTK+ bindings for guile"
HOMEPAGE="http://www.gnu.org/software/guile-gtk/"
SRC_URI="ftp://ftp.gnu.org/gnu/guile-gtk/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-scheme/guile
	=x11-libs/gtk+-2*
	=gnome-base/libglade-2*
	>=x11-libs/gtkglarea-1.90"
DEPEND="${RDEPEND}"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		local flags="deprecated"
		built_with_use dev-scheme/guile ${flags} || die "guile must be built with \"${flags}\" use flag"
	fi
}

src_test() {
	Xemake check || die "tests failed"
}

src_install() {
	make DESTDIR="${D}" install
	dodoc README AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/doc/${PF}/examples
	doins -r examples/
}
