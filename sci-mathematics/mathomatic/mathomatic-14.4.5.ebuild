# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-14.4.5.ebuild,v 1.2 2009/06/24 04:34:02 bicatali Exp $

inherit eutils

DESCRIPTION="Automatic algebraic manipulator"
HOMEPAGE="http://www.mathomatic.com/"
SRC_URI="http://www.panix.com/~gesslein/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc secure"

DEPEND="sys-libs/readline
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	sed -i \
		-e '/^CFLAGS/ s/-O.//' \
		makefile primes/makefile || die "sed failed"
	sed -i -e "s/-s.*-O/${CFLAGS}/" compile.secure || die
	emake READLINE=1 || die "emake failed"
	emake -C primes || die "emake in primes failed"
	if use secure; then
		./compile.secure || die "compiling secure version failed"
	fi
}

src_test() {
	emake test || die "emake test failed"
	emake -C primes test || die "emake test in primes failed"
}

src_install() {
	# It was easier just to install the files manually
	dobin mathomatic primes/matho-{primes,pascal,sumsq} || die
	dodoc changes.txt README.txt AUTHORS || die
	doman mathomatic.1 primes/*.1 || die
	doicon icons/mathomatic.png || die
	domenu icons/mathomatic.desktop || die
	newdoc primes/README.txt README-primes.txt || die
	if use doc; then
		dohtml doc/* || die
		insinto /usr/share/doc/${PF}
		doins -r tests factorial m4 || die
	fi
	if use secure; then
		dobin mathomatic_secure || die
	fi
}
