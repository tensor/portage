# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-2.0.0-r1.ebuild,v 1.2 2009/03/22 16:26:25 maekke Exp $

EAPI=2

inherit eutils

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools"
SRC_URI="mirror://kernel/linux/kernel/people/horms/kexec-tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="xen zlib"
DEPEND="zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-asneeded.patch"
	epatch "${FILESDIR}/${P}-respect-LDFLAGS.patch"
}

src_configure() {
	econf $(use_with zlib) $(use_with xen)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doman kexec/kexec.8
	dodoc News AUTHORS TODO

	newinitd "${FILESDIR}"/kexec.init kexec || die
	newconfd "${FILESDIR}"/kexec.conf kexec || die
}
