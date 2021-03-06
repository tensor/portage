# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-qt4/poppler-qt4-0.10.4.ebuild,v 1.6 2009/04/05 15:34:38 armin76 Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-qt4.so"
HOMEPAGE="http://poppler.freedesktop.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

PROPERTIES="virtual"

RDEPEND="~app-text/poppler-bindings-${PV}[qt4]"
DEPEND="${RDEPEND}"
