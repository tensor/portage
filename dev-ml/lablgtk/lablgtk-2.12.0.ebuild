# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgtk/lablgtk-2.12.0.ebuild,v 1.2 2009/07/27 08:02:19 aballier Exp $

EAPI="2"

inherit eutils multilib

IUSE="debug examples glade gnome gnomecanvas sourceview +ocamlopt opengl spell svg"

DESCRIPTION="Objective CAML interface for Gtk+2"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgtk.html"
SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
LICENSE="LGPL-2.1 as-is"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-lang/ocaml-3.10[ocamlopt?]
	svg? ( >=gnome-base/librsvg-2.2 )
	glade? ( >=gnome-base/libglade-2.0.1 )
	gnomecanvas? ( >=gnome-base/libgnomecanvas-2.2 )
	gnome? ( >=gnome-base/gnome-panel-2.4.0
		>=gnome-base/libgnomeui-2.4.0 )
	opengl? ( >=dev-ml/lablgl-0.98
		>=x11-libs/gtkglarea-1.9 )
	spell? ( app-text/gtkspell )
	sourceview? ( =x11-libs/gtksourceview-1* )
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"

src_prepare() {
	epatch "${FILESDIR}/${P}-libgnomeui.patch"
}

src_configure() {
	econf $(use_enable debug) \
		$(use_with svg rsvg) \
		$(use_with glade) \
		$(use_with gnome gnomeui) \
		$(use_with gnome panel) \
		$(use_with opengl gl) \
		$(use_with spell gtkspell) \
		$(use_with sourceview gtksourceview) \
		$(use_with gnomecanvas)
}

src_compile() {
	emake -j1 all || die "make failed"
	if use ocamlopt; then
		emake -j1 opt || die "Compiling native code failed"
	fi
}

install_examples() {
	insinto /usr/share/doc/${P}/examples
	doins examples/*.ml examples/*.rgb examples/*.png examples/*.xpm

	# Install examples for optional components
	use gnomecanvas && insinto /usr/share/doc/${P}/examples/canvas && doins examples/canvas/*.ml examples/canvas/*.png
	use svg && insinto /usr/share/doc/${P}/examples/rsvg && doins examples/rsvg/*.ml examples/rsvg/*.svg
	use glade && insinto /usr/share/doc/${P}/examples/glade && doins examples/glade/*.ml examples/glade/*.glade*
	use sourceview && insinto /usr/share/doc/${P}/examples/sourceview && doins examples/sourceview/*.ml examples/sourceview/*.lang
	use opengl && insinto /usr/share/doc/${P}/examples/GL && doins examples/GL/*.ml
	use gnome && insinto /usr/share/doc/${P}/examples/panel && doins examples/panel/*
}

src_install () {
	emake install DESTDIR="${D}" || die

	# ocamlfind support
	dosym /usr/$(get_libdir)/ocaml/lablgtk2 /usr/$(get_libdir)/ocaml/site-packages/lablgtk2
	insinto /usr/$(get_libdir)/ocaml/lablgtk2
	doins META

	dodoc CHANGES README CHANGES.API
	use examples && install_examples
}

pkg_postinst () {
	use examples && elog "To run the examples you can use the lablgtk2 toplevel."
	use examples && elog "e.g: lablgtk2 /usr/share/doc/${P}/examples/testgtk.ml"
}
