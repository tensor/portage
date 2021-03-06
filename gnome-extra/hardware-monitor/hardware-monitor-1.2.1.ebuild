# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hardware-monitor/hardware-monitor-1.2.1.ebuild,v 1.1 2006/02/10 17:27:52 agriffis Exp $

inherit gnome2

DESCRIPTION="Gnome2 Hardware Monitor Applet"
HOMEPAGE="http://www.cs.auc.dk/~olau/hardware-monitor/"
SRC_URI="http://www.cs.auc.dk/~olau/hardware-monitor/source/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
# can add lmsensor stuff
IUSE=""

RDEPEND=">=dev-cpp/libgnomeuimm-2.6.0
		>=dev-cpp/gconfmm-2.6.0
		>=dev-cpp/gtkmm-2.4.0
		>=dev-cpp/libgnomecanvasmm-2.6.0
		>=dev-cpp/libglademm-2.4.0
		>=gnome-base/gnome-panel-2
		>=gnome-base/libgtop-2.6.0"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		>=dev-util/intltool-0.29"
