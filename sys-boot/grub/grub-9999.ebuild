# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-9999.ebuild,v 1.11 2009/07/05 04:17:11 vapier Exp $

inherit autotools mount-boot eutils flag-o-matic toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="svn://svn.sv.gnu.org/grub/trunk/grub2"
	inherit subversion
	SRC_URI=""
else
	SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz
		mirror://gentoo/${P}.tar.gz"
fi

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"

LICENSE="GPL-3"
use multislot && SLOT="2" || SLOT="0"
KEYWORDS=""
IUSE="custom-cflags debug multislot static"

RDEPEND=">=sys-libs/ncurses-5.2-r5
	dev-libs/lzo"
DEPEND="${RDEPEND}
	dev-lang/ruby"
PROVIDE="virtual/bootloader"

export STRIP_MASK="*/grub/*/*.mod"
QA_EXECSTACK="sbin/grub-probe sbin/grub-setup"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.96-genkernel.patch #256335
	sed -i 's:-Werror::' conf/*.rmk || die #269887

	# autogen.sh does more than just run autotools
	sed -i -e 's:^auto:eauto:' autogen.sh
	(. ./autogen.sh) || die
}

src_compile() {
	use custom-cflags || unset CFLAGS CPPFLAGS LDFLAGS
	use static && append-ldflags -static

	econf \
		--sbindir=/sbin \
		--bindir=/bin \
		--libdir=/$(get_libdir) \
		--disable-efiemu \
		--disable-grub-pe2elf \
		--enable-grub-mkfont \
		$(use_enable debug mm-debug) \
		$(use_enable debug grub-emu) \
		$(use_enable debug grub-emu-usb) \
		$(use_enable debug grub-fstest)
	emake -j1 || die "making regular stuff"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	cat <<-EOF >> "${D}"/lib*/grub/grub-mkconfig_lib
	GRUB_DISTRIBUTOR="Gentoo"
	EOF
	if use multislot ; then
		sed -i s:grub-install:grub2-install: "${D}"/sbin/grub-install
		mv "${D}"/sbin/grub{,2}-install || die
		mv "${D}"/usr/share/man/man8/grub{,2}-install.8 || die
	fi
}

setup_boot_dir() {
	local boot_dir=$1
	local dir=${boot_dir}/grub

	if [[ ! -e ${dir}/grub.cfg ]] ; then
		einfo "Running: grub-mkconfig -o '${dir}/grub.cfg'"
		grub-mkconfig -o "${dir}/grub.cfg"
	fi

	#local install=grub-install
	#use multislot && install="grub2-install --grub-setup=/bin/true"
	#einfo "Running: ${install} "
	#${install}
}

pkg_postinst() {
	if use multislot ; then
		elog "You have installed grub2 with USE=multislot, so to coexist"
		elog "with grub1, the grub2 install binary is named grub2-install."
	fi
	setup_boot_dir "${ROOT}"boot
}
