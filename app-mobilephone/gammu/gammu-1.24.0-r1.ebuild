# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.24.0-r1.ebuild,v 1.2 2009/06/15 21:24:16 mrness Exp $

EAPI="2"

inherit cmake-utils distutils

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="http://dl.cihar.com/gammu/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="curl debug bluetooth irda mysql postgres dbi nls usb"

RDEPEND="bluetooth? ( || ( net-wireless/bluez net-wireless/bluez-libs ) )
	curl? ( net-misc/curl )
	usb? ( dev-libs/libusb:1 )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	dbi? ( >=dev-db/libdbi-0.8.3 )
	dev-util/dialog
	dev-lang/python
	!dev-python/python-gammu" # needs to be removed from the tree
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	dev-util/cmake"

# sys-devel/gettext is needed for creating .mo files
# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" af bg ca cs da de el es et fi fr gl he hu id it ko nl pl pt_BR ru sk sv zh_CN zh_TW"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_prepare() {
	local lang support_linguas=no
	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if use linguas_${lang} ; then
			support_linguas=yes
			break
		fi
	done
	# install all languages when all selected LINGUAS aren't supported
	if [ "${support_linguas}" = "yes" ]; then
		for lang in ${MY_AVAILABLE_LINGUAS} ; do
			if ! use linguas_${lang} ; then
				rm -rf locale/${lang} || die
			fi
		done
	fi
}

src_configure() {
	# debug flag is used inside cmake-utils.eclass
	local mycmakeargs="$(cmake-utils_use_with bluetooth Bluez) \
		$(cmake-utils_use_with irda IRDA) \
		$(cmake-utils_use_with curl CURL) \
		$(cmake-utils_use_with usb USB) \
		$(cmake-utils_use_with mysql MySQL) \
		$(cmake-utils_use_with postgres Postgres) \
		$(cmake-utils_use_with dbi LibDBI) \
		$(cmake-utils_use_with nls GettextLibs) \
		$(cmake-utils_use_with nls Iconv) \
		-DBUILD_SHARED_LIBS=ON -DINSTALL_DOC_DIR=share/doc/${PF} \
		-DBUILD_PYTHON=/usr/bin/python"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	LD_LIBRARY_PATH="${WORKDIR}"/${PN}_build/common cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
}
