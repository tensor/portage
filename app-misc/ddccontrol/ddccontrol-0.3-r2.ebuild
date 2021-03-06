# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ddccontrol/ddccontrol-0.3-r2.ebuild,v 1.1 2006/02/27 00:17:01 robbat2 Exp $

inherit eutils autotools

DESCRIPTION="DDCControl allows control of monitor parameters via DDC"
HOMEPAGE="http://ddccontrol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gnome doc nls"

RDEPEND="dev-libs/libxml2
	gtk? ( >=x11-libs/gtk+-2.4 )
	gnome? ( >=gnome-base/gnome-panel-2.10 )
	sys-apps/pciutils
	nls? ( sys-devel/gettext )
	>=app-misc/ddccontrol-db-20051114"
DEPEND="${RDEPEND}
	doc? ( >=app-text/docbook-xsl-stylesheets-1.65.1
		   >=dev-libs/libxslt-1.1.6
	       app-text/htmltidy )
	sys-kernel/linux-headers"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix --as-needed errors
	epatch ${FILESDIR}/${PN}-asneeded.patch
	epatch ${FILESDIR}/${P}-u64-conflicting-types.patch
	epatch ${FILESDIR}/${P}-fix-libpanelapplet-dep.patch

	# Fix sandbox violation
	for i in Makefile.am Makefile.in; do
		sed -i.orig "${S}/src/gddccontrol/${i}" \
		-e "/@INSTALL@/s/ \$(datadir)/ \$(DESTDIR)\/\$(datadir)/" \
		|| die "Failed to fix DESTDIR"
	done

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf $(use_enable doc) \
		$(use_enable gtk gnome) \
		$(use_enable gnome gnome-applet) \
		$(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" htmldir="/usr/share/doc/${PF}/html" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
