# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-0.35.20090202.ebuild,v 1.1 2009/04/18 18:13:25 calchan Exp $

inherit multilib

SNAPSHOTDATE="${P##*.}"
MY_PV="${PN}-${SNAPSHOTDATE:0:4}-${SNAPSHOTDATE:4:2}-${SNAPSHOTDATE:6:2}"

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://www.gnucap.org/devel/${MY_PV}.tar.gz
	http://www.gnucap.org/devel/${MY_PV}-models-bsim.tar.gz
	http://www.gnucap.org/devel/${MY_PV}-models-jspice3-2.5.tar.gz
	http://www.gnucap.org/devel/${MY_PV}-models-ngspice17.tar.gz
	http://www.gnucap.org/devel/${MY_PV}-models-spice3f5.tar.gz"
HOMEPAGE="http://www.gnucap.org/"

IUSE="examples"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_PV}"

src_unpack() {
	unpack ${A} || die "Failed to unpack!"
	cd "${S}"

	# No need to install COPYING and INSTALL
	sed -i \
		-e 's: COPYING INSTALL::' \
		-e 's:COPYING history INSTALL:history:' \
		doc/Makefile.in || die "sed failed"

	if ! use examples ; then
		sed -i \
			-e 's:examples modelgen:modelgen:' \
			Makefile.in || die "sed failed"
	fi

	sed -i -e 's:CFLAGS = -O2 -g:CPPFLAGS +=:' \
		-e '/CCFLAGS =/i\CFLAGS += $(CPPFLAGS)' \
		-e 's:CCFLAGS = $(CFLAGS):CXXFLAGS += $(CPPFLAGS):' \
		-e 's:LDFLAGS = :LDFLAGS += :' \
		-e 's:CCFLAGS:CXXFLAGS:' \
		-e "s:../Gnucap:${S}/src:" \
		models-*/Make2 || die "sed failed"
}

src_compile () {
	econf --disable-dependency-tracking
	emake || die "Compilation failed"
	for PLUGIN_DIR in models-* ; do
		cd "${S}/${PLUGIN_DIR}"
		emake || die "Compilation failed in ${PLUGIN_DIR}"
	done
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed"
	insopts -m0755
	for PLUGIN_DIR in models-* ; do
		insinto /usr/$(get_libdir)/gnucap/${PLUGIN_DIR}
		cd "${S}/${PLUGIN_DIR}"
		for PLUGIN in */*.so ; do
			newins ${PLUGIN} ${PLUGIN##*/} \
			|| die "Installation of ${PLUGIN_DIR}/${PLUGIN} failed"
		done
	done
}

pkg_postinst() {
	elog "Documentation for development releases is now available at :"
	elog "    http://wiki.gnucap.org/dokuwiki/doku.php?id=gnucap:manual"
}
