# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-nl/man-pages-nl-0.13.3.ebuild,v 1.2 2006/06/21 17:25:50 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Dutch Linux man pages"
HOMEPAGE="http://doc.nl.linux.org/MANPAGE/"
SRC_URI="ftp://ftp.nl.linux.org/pub/DOC-NL/manpages-nl/manpages-nl-${PV}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/man"

S=${WORKDIR}/manpages-nl-${PV}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
