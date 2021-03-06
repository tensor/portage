# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.11.1.ebuild,v 1.3 2009/06/20 16:12:58 aballier Exp $

EAPI="1"

inherit flag-o-matic eutils multilib versionator toolchain-funcs

PATCHLEVEL="1"
MY_P="${P/_/+}"
DESCRIPTION="Fast modern type-inferring functional programming language descended from the ML family"
HOMEPAGE="http://www.ocaml.org/"
SRC_URI="ftp://ftp.inria.fr/INRIA/cristal/ocaml/ocaml-$( get_version_component_range 1-2)/${MY_P}.tar.gz
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="emacs gdbm latex ncurses +ocamlopt tk X xemacs"

DEPEND="tk? ( >=dev-lang/tk-3.3.3 )
	ncurses? ( sys-libs/ncurses )
	X? ( x11-libs/libX11 x11-proto/xproto )
	gdbm? ( sys-libs/gdbm )"
RDEPEND="${DEPEND}"

PDEPEND="emacs? ( app-emacs/ocaml-mode )
	xemacs? ( app-xemacs/ocaml )"

S="${WORKDIR}/${MY_P}"
pkg_setup() {
	# dev-lang/ocaml creates its own objects but calls gcc for linking, which will
	# results in relocations if gcc wants to create a PIE executable
	if gcc-specs-pie ; then
		append-ldflags -nopie
		ewarn "Ocaml generates its own native asm, you're using a PIE compiler"
		ewarn "We have appended -nopie to ocaml build options"
		ewarn "because linking an executable with pie while the objects are not pic will not work"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
}

src_compile() {
	export LC_ALL=C
	local myconf=""

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	use tk || myconf="${myconf} -no-tk"
	use ncurses || myconf="${myconf} -no-curses"
	use X || myconf="${myconf} -no-graph"
	use gdbm || myconf="${myconf} -no-dbm"

	# ocaml uses a home-brewn configure script, preventing it to use econf.
	RAW_LDFLAGS="$(raw-ldflags)" ./configure -prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/$(get_libdir)/ocaml \
		--mandir /usr/share/man \
		-host "${CHOST}" \
		-cc "$(tc-getCC)" \
		-as "$(tc-getAS)" \
		-aspp "$(tc-getCC) -c" \
		--with-pthread ${myconf} || die "configure failed!"

	make world || die "make world failed!"

	# Native code generation can be disabled now
	if use ocamlopt ; then
		make opt || die "make opt failed!"
		make opt.opt || die "make opt.opt failed!"
	fi
}

src_install() {
	make BINDIR="${D}"/usr/bin \
		LIBDIR="${D}"/usr/$(get_libdir)/ocaml \
		MANDIR="${D}"/usr/share/man \
		install || die "make install failed!"

	# Install the compiler libs
	dodir /usr/$(get_libdir)/ocaml/compiler-libs
	insinto /usr/$(get_libdir)/ocaml/compiler-libs
	doins {utils,typing,parsing}/*.{mli,cmi,cmo}
	use ocamlopt && doins {utils,typing,parsing}/*.{cmx,o}

	# Symlink the headers to the right place
	dodir /usr/include
	dosym /usr/$(get_libdir)/ocaml/caml /usr/include/

	# Remove ${D} from ld.conf, as the buildsystem isn't $(DESTDIR) aware
	dosed "s:${D}::g" /usr/$(get_libdir)/ocaml/ld.conf

	dodoc Changes INSTALL README Upgrading

	# Create and envd entry for latex input files (this definitely belongs into
	# CONTENT and not in pkg_postinst.
	if use latex ; then
		echo "TEXINPUTS=/usr/$(get_libdir)/ocaml/ocamldoc:" > "${T}"/99ocamldoc
		doenvd "${T}"/99ocamldoc
	fi

	# Install ocaml-rebuild.sh script rather than keeping it in $PORTDIR
	dosbin "${FILESDIR}/ocaml-rebuild.sh"
}

pkg_postinst() {
	echo
	ewarn "OCaml is not binary compatible from version to version, so you"
	ewarn "need to rebuild all packages depending on it, that are actually"
	ewarn "installed on your system. To do so, you can run:"
	ewarn "/usr/sbin/ocaml-rebuild.sh [-h | emerge options]"
	ewarn "Which will call emerge on all old packages with the given options"
	echo
}
