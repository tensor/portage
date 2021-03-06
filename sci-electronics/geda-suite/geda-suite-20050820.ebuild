# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-suite/geda-suite-20050820.ebuild,v 1.5 2008/03/23 20:24:00 calchan Exp $

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="Metapackage which installs all the components required for a full-featured gEDA/gaf system"
IUSE=''
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="sci-electronics/geda
	>=sci-electronics/gerbv-1.0.1
	>=sci-electronics/gnucap-0.35
	>=sci-electronics/gwave-20031224
	>=sci-electronics/pcb-20050609
	>=sci-electronics/iverilog-0.8
	>=sci-electronics/ng-spice-rework-15
	>=sci-electronics/gnetman-0.0.1_pre20041222
	sci-electronics/gtkwave"
