# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.27.2.1-r2.ebuild,v 1.3 2009/07/22 05:54:03 pva Exp $

inherit versionator

# Upstream uses string to version their releases. To make portage version
# comparisment working we have to use numbers instead of strings, that is 4th
# component of our version. So we have aivazovsky - 1, briullov - 2 and so on.
# Keep this string on top since we have to modify it each new release.
OVZ_CODENAME="briullov"
OVZ_CODENAME_SUBRELEASE=$(get_version_component_range 5)

OVZ_KV="${OVZ_CODENAME}.${OVZ_CODENAME_SUBRELEASE}"

ETYPE="sources"

CKV=$(get_version_component_range 1-3)
OKV=${OKV:-${CKV}}
EXTRAVERSION=-${PN/-*}-${OVZ_KV}
KV_FULL=${CKV}${EXTRAVERSION}
if [[ ${PR} != r0 ]]; then
	KV_FULL+=-${PR}
	EXTRAVERSION+=-${PR}
fi

# ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} should succeed.
KV_MAJOR=$(get_version_component_range 1 ${OKV})
KV_MINOR=$(get_version_component_range 2 ${OKV})
KV_PATCH=$(get_version_component_range 3 ${OKV})

KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"

inherit kernel-2
detect_version

SLOT=${CKV}-${OVZ_KV}
if [[ ${PR} != r0 ]]; then
	SLOT+=-${PR}
fi

KEYWORDS="amd64 ~ia64 ~ppc64 ~sparc x86"
IUSE=""

DESCRIPTION="Kernel sources with OpenVZ patchset"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://download.openvz.org/kernel/branches/${CKV}/${CKV}-${OVZ_KV}/patches/patch-${OVZ_KV}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-${OVZ_KV}-combined.gz
${FILESDIR}/${PN}-2.6.27.2.1-ban-netns-creation.patch
${FILESDIR}/${PN}-2.6.27.2.1-bridge-process-skbs.patch
${FILESDIR}/${PN}-2.6.27.2.1-bridge-set_via_phys_dev_state.patch
${FILESDIR}/${PN}-2.6.27.2.1-avoid-double-free.patch
${FILESDIR}/${PN}-2.6.27.2.1-check-for-no-mmaps.patch
${FILESDIR}/${PN}-2.6.27.2.1-pi-futex-pid-check-fixup.patch
${FILESDIR}/${PN}-2.6.27.2.1-SLAB.patch"

K_EXTRAEINFO="For more information about this kernel take a look at:
http://wiki.openvz.org/Download/kernel/${CKV}/${CKV}-${OVZ_KV}"
