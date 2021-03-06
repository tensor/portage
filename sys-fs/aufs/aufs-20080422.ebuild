# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod

DESCRIPTION="An entirely re-designed and re-implemented Unionfs."
HOMEPAGE="http://aufs.sourceforge.net/"
SRC_URI="http://dev.gentooexperimental.org/~tommy/${P}.tar.bz2
	http://dev.gentoo.org/~tommy/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fuse hinotify nfsexport robr"

S="${WORKDIR}"/aufs

MODULE_NAMES="aufs(misc:${S})"

pkg_setup() {
	# kernel version check
	if kernel_is lt 2 6 16 ; then
		eerror "${PN} is being developed and tested on linux-2.6.16 and later."
		eerror "Make sure you have a proper kernel version!"
		die "Wrong kernel version"
	fi

	if kernel_is ge 2 6 24 && linux_chkconfig_present "SECURITY" ; then
		APPLY_SEC_PERM_PATCH="n"
		if ! grep -qs "EXPORT_SYMBOL(security_inode_permission);" "${KV_DIR}/security/security.c" ; then
			APPLY_SEC_PERM_PATCH="y"
		fi

		# make sure the user is allowing this to happen
		if [[ APPLY_SEC_PERM_PATCH = "y" ]] ; then
			eerror "${PN} requires that all kernels with CONFIG_SECURITY enabled >= 2.6.24"
			eerror "be patched.  Please enable visit ${HOMEPAGE} and read"
			eerror "about the sec_perm patch to enable ${PN} support."
			die "Invalid kernel configuration, we won't compile if CONFIG_SECURITY is enabled"
		fi
	fi

	linux-mod_pkg_setup
}

src_unpack(){
	unpack ${A}
	cd "${S}"

	# Enable hinotify in priv_def.mk
	if use hinotify && kernel_is ge 2 6 18 ; then
		echo "CONFIG_AUFS_HINOTIFY = y" >> priv_def.mk || die "setting hinotify in priv_def.mk failed!"
	fi

	# Disable SYSAUFS for kernel less than 2.6.18
	if kernel_is lt 2 6 18 ; then
		echo "CONFIG_AUFS_SYSAUFS = " >> priv_def.mk || die "unsetting sysaufs in priv_def.mk failed!"
	fi

	# Enable nfsexport in priv_def.mk
	if use nfsexport && kernel_is ge 2 6 18 ; then
		echo "CONFIG_AUFS_EXPORT = y" >> priv_def.mk || die "setting export in priv_def.mk failed!"
	fi

	# Enable aufs readonly-branch in priv_def.mk
	if use robr ; then
		echo "CONFIG_AUFS_ROBR = y" >> priv_def.mk || die "setting robr in priv_def.mk failed!"
	fi

	# Enable FUSE workaround for AUFS
	if use fuse ; then
		echo "CONFIG_AUFS_WORKAROUND_FUSE = y" >> priv_def.mk || die "setting workaround_fuse in priv_def.mk failed!"
	fi

	# Enable / Disable debugging
	if use debug ; then
		echo "CONFIG_AUFS_DEBUG = y" >> priv_def.mk || die "setting debug in priv_dev.mk failed!"
	else
		echo "CONFIG_AUFS_DEBUG = " >> priv_def.mk || die "setting debug in priv_dev.mk failed!"
	fi

	# Check if a vserver-kernel is installed
	if [[ -e ${KV_DIR}/include/linux/vserver ]] ; then
		einfo "vserver kernel seems to be installed"
		einfo "using vserver patch"
		echo "AUFS_DEF_CONFIG = -DVSERVER" >> priv_def.mk || die "setting vserver in priv_def.mk failed!"
	fi
}

src_compile() {
	use x86 && ARCH=i386
	use amd64 && ARCH=x86_64
	emake KDIR=${KV_DIR} SUBLEVEL=${KV_PATCH} -f local.mk || die "emake failed"
}

src_install() {
	cd util
	exeinto /sbin
	exeopts -m0500
	doexe mount.aufs umount.aufs auplink aulchown
	doman aufs.5
	linux-mod_src_install
}

pkg_postinst() {
	elog "To be able to use aufs, you have to load the kernel module by typing:"
	elog "modprobe aufs"
	elog "For further information refer to the aufs man page"

	linux-mod_pkg_postinst
}
