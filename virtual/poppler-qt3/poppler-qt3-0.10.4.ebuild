# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-qt3/poppler-qt3-0.10.4.ebuild,v 1.4 2009/04/04 16:18:31 armin76 Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-qt.so"
HOMEPAGE="http://poppler.freedesktop.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

PROPERTIES="virtual"

RDEPEND="~app-text/poppler-bindings-${PV}[qt3]"
DEPEND="${RDEPEND}"
