# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf/hdf-4.2_p4.ebuild,v 1.1 2009/04/16 20:24:04 bicatali Exp $

EAPI=2
inherit eutils toolchain-funcs autotools flag-o-matic

MYP="HDF${PV/_p/r}"

DESCRIPTION="General purpose library and format for storing scientific data"
HOMEPAGE="http://www.hdfgroup.org/hdf4.html"
SRC_URI="ftp://ftp.hdfgroup.org/HDF/HDF_Current/src/${MYP}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2"

LICENSE="NCSA-HDF"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="fortran netcdf szip"

RDEPEND="sys-libs/zlib
	media-libs/jpeg
	szip? ( >=sci-libs/szip-2 )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	# for s390, sparc and ppc to work (from fedora)
	epatch "${WORKDIR}"/${P}-arches.patch
	epatch "${WORKDIR}"/${P}-buffer.patch

	epatch "${WORKDIR}"/${P}-configure.ac.patch
	epatch "${WORKDIR}"/${P}-fortran.patch
	epatch "${WORKDIR}"/${P}-maxavailfiles.patch
	epatch "${WORKDIR}"/${P}-as-needed.patch
	epatch "${WORKDIR}"/${P}-include.patch
	sed -i \
		-e 's|-O3 -fomit-frame-pointer||g' \
		-e 's|-Wsign-compare||g' \
		"${S}"/config/* || die "sed failed"
	eautoreconf
	[[ $(tc-getFC) = *gfortran ]] && append-fflags -fno-range-check
}

src_configure() {
	econf \
		--enable-shared \
		--enable-production \
		$(use_enable fortran) \
		$(use_enable netcdf) \
		$(use_with szip szlib) \
		F77="$(tc-getFC)"
}

src_test() {
	LD_LIBRARY_PATH="${S}"/mfhdf/libsrc/.libs:${LD_LIBRARY_PATH} \
		emake -j1 check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README release_notes/*.txt
	if use netcdf; then
		einfo "Renaming ncdump and ncgen to ncdump-hdf and ncgen-hdf"
		cd "${D}"usr
		mv bin/ncgen{,-hdf} || die
		mv bin/ncdump{,-hdf} || die
		mv share/man/man1/ncgen{,-hdf}.1 || die
		mv share/man/man1/ncdump{,-hdf}.1 || die
		for i in include/netcdf*; do
			mv ${i} ${i/cdf/cdf-hdf}
		done
	fi
}
