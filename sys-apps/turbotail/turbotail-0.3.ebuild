# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/turbotail/turbotail-0.3.ebuild,v 1.6 2008/12/15 21:18:28 jer Exp $

inherit toolchain-funcs

DESCRIPTION="drop-in replacement for 'tail' which uses the kernel DNOTIFY-api"
HOMEPAGE="http://www.vanheusden.com/turbotail/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa ~ppc ~sparc ~x86"
IUSE="fam"

DEPEND="fam? ( || ( app-admin/gamin app-admin/fam ) )"

src_compile() {
	local myconf
	if use fam; then
		myconf="-DUSE_FAM -lfam"
	else
		myconf="-DUSE_DNOTIFY"
	fi

	echo "$(tc-getCC) ${myconf} -DVERSION=\"${PV}\" ${PN}.c -o ${PN}"
	$(tc-getCC) ${myconf} -DVERSION=\"${PV}\" ${PN}.c -o ${PN} \
		|| die "compile failed"
}

src_install() {
	dobin turbotail || die "install failed"
	dodoc readme.txt
}
