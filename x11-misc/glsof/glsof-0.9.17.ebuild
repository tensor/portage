# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glsof/glsof-0.9.17.ebuild,v 1.5 2007/02/21 18:51:35 ticho Exp $

inherit gnome2  # Saves us work

DESCRIPTION="GTK+ GUI for LSOF"
HOMEPAGE="http://glsof.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PF}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=dev-libs/glib-2
	dev-libs/libxml2
	sys-process/lsof"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	sed -i -e "s:^glsof_LDFLAGS = :glsof_LDFLAGS = -export-dynamic :" \
		src/Makefile.in
}

DOCS="AUTHORS COPYING ChangeLog INSTALL README"
