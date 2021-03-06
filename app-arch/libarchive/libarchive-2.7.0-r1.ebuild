# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libarchive/libarchive-2.7.0-r1.ebuild,v 1.5 2009/07/31 15:49:30 chainsaw Exp $

EAPI=1

inherit eutils libtool toolchain-funcs flag-o-matic

DESCRIPTION="BSD tar command"
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz
	http://people.freebsd.org/~kientzle/libarchive/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="static acl xattr kernel_linux +bzip2 +lzma +zlib"

COMPRESS_LIBS_DEPEND="lzma? ( app-arch/lzma-utils )
		bzip2? ( app-arch/bzip2 )
		zlib? ( sys-libs/zlib )"

RDEPEND="!dev-libs/libarchive
	dev-libs/openssl
	acl? ( virtual/acl )
	xattr? ( kernel_linux? ( sys-apps/attr ) )
	!static? ( ${COMPRESS_LIBS_DEPEND} )"
DEPEND="${RDEPEND}
	${COMPRESS_LIBS_DEPEND}
	kernel_linux? ( sys-fs/e2fsprogs
		virtual/os-headers )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-fortified-sources.patch
	epatch "${FILESDIR}"/${P}-pipe.patch

	elibtoolize
	epunt_cxx
}

src_compile() {
	local myconf

	if ! use static ; then
		myconf="--enable-bsdtar=shared --enable-bsdcpio=shared"
	fi

	# Check for need of this in 2.7.1 and later, on 2.7.0, -Werror was
	# added to the final release, but since it's done in the
	# Makefile.am we can just work it around this way.
	append-flags -Wno-error

	# We disable lzma because we don't have liblzma (not liblzmadec!)
	# currently.
	econf --bindir=/bin \
		--enable-bsdtar --enable-bsdcpio \
		$(use_enable acl) $(use_enable xattr) \
		$(use_with zlib) \
		$(use_with bzip2 bz2lib) $(use_with lzma lzmadec) \
		--without-lzma \
		${myconf} \
		--disable-dependency-tracking || die "econf failed."

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	# Create tar symlink for FreeBSD
	if [[ ${CHOST} == *-freebsd* ]]; then
		dosym bsdtar /bin/tar
		dosym bsdtar.1 /usr/share/man/man1/tar.1
		# We may wish to switch to symlink bsdcpio to cpio too one day
	fi

	dodoc NEWS README
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)
	gen_usr_ldscript libarchive.so
}
