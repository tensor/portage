# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-2.4.2.ebuild,v 1.6 2009/02/13 15:30:19 tgurr Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Provides a virtual printer for CUPS to produce PDF files."
HOMEPAGE="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/"
SRC_URI="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/src/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="net-print/cups
	virtual/ghostscript"
RDEPEND="${DEPEND}"

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} -o cups-pdf cups-pdf.c || die "Compilation failed."
}

src_install () {
	exeinto $(cups-config --serverbin)/backend
	has_version '>=net-print/cups-1.2' && exeopts -m0700
	doexe src/cups-pdf

	insinto /usr/share/cups/model
	doins extra/PostscriptColor.ppd

	insinto /etc/cups
	doins extra/cups-pdf.conf

	dodoc ChangeLog README
	newdoc contrib/Contents contrib_Contents
}

pkg_postinst () {
	elog "Please view both the README and contrib_Contents files"
	elog "as you may want to adjust some settings and/or use"
	elog "contributed software. In the latter case you may need"
	elog "to extract some files from the ${P} distfile."
}
