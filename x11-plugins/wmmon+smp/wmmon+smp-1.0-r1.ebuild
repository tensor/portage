# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon+smp/wmmon+smp-1.0-r1.ebuild,v 1.11 2007/07/22 04:49:01 dberkholz Exp $

IUSE=""

S=${WORKDIR}/wmmon.app
S2=${S}/wmmon
DESCRIPTION="Dockapp CPU monitor resembling Xosview, support for smp"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/wmmon+smp.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc64"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_compile() {
	cd ${S2}
	emake || die
}

src_install () {
	exeinto /usr/bin
	cp ${S2}/wmmon ${S2}/wmmon+smp
	doexe ${S2}/wmmon+smp
	dodoc ${S}/README ${S}/COPYING ${S}/INSTALL
}
