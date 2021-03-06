# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/datutil/datutil-2.45.ebuild,v 1.2 2009/03/04 17:14:55 drizzt Exp $

inherit toolchain-funcs

DL_PV=2.35
DESCRIPTION="Converter for dat files for Rom Managers"
HOMEPAGE="http://www.logiqx.com/Tools/DatUtil/"
SRC_URI="http://www.logiqx.com/Tools/DatUtil/dutil${PV//.}.zip
	http://www.logiqx.com/Tools/DatLib/datlib${DL_PV//.}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack dutil${PV//.}.zip
	cd "${S}"
	mkdir -p dev/datlib
	cd dev/datlib
	unpack datlib${DL_PV//.}.zip
}

src_compile() {
	# Parallel make issue, see bug #244879 (so make the dirs first)
	emake CC="$(tc-getCC)" LD="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" \
	CFLAGS="${CFLAGS} -Idev" LOGIQX=. EXT= UPX=@# dlmaketree maketree || die "emake failed"
	emake CC="$(tc-getCC)" LD="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" \
	CFLAGS="${CFLAGS} -Idev" LOGIQX=. EXT= UPX=@# || die "emake failed"
}

src_install() {
	dobin datutil || die "cannot install datutil"
	dodoc readme.txt whatsnew.txt
}
