# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/x86info/x86info-1.24-r2.ebuild,v 1.2 2009/07/10 20:45:43 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Dave Jones' handy, informative x86 CPU diagnostic utility"
HOMEPAGE="http://www.codemonkey.org.uk/projects/x86info/"
SRC_URI="http://www.codemonkey.org.uk/projects/x86info/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/1.21-pic.patch
	sed -i -e 's:$(CFLAGS) -o x86:$(LDFLAGS) $(CFLAGS) -o x86:' \
		Makefile || die "I don't want your LDFLAGS."
}

src_compile() {
	emake x86info CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" || die "emake failed"
}

pkg_preinst() {
	if [[ -a /etc/modules.d/x86info ]] && [[ ! -a /etc/modprobe.d/x86info ]]; then
		elog "Moving old x86info configuration in modules.d to new"
		elog "location in modprobe.d in /etc/"
		mv "${ROOT}"/etc/{modules,modprobe}.d/x86info
	fi
	if [[ -a /etc/modprobe.d/x86info ]] && [[ ! -a /etc/modprobe.d/x86info.conf ]]; then
		elog "Moving old x86info configuration in modprobe.d to"
		elog "new naming scheme with trailing .conf"
		mv "${ROOT}"/etc/modprobe.d/x86info{,.conf}
	fi
}

src_install() {
	dobin x86info || die

	insinto /etc/modprobe.d
	newins "${FILESDIR}"/x86info-modules.conf-rc x86info.conf

	dodoc TODO README
	doman x86info.1
	insinto /usr/share/doc/${PF}
	doins -r results
	prepalldocs
}

pkg_postinst() {
	ewarn "Your kernel must be built with the following options"
	ewarn "set to Y or M"
	ewarn "     Processor type and features ->"
	ewarn "         [*] /dev/cpu/*/msr - Model-specific register support"
	ewarn "         [*] /dev/cpu/*/cpuid - CPU information support"
}
