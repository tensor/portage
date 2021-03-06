# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/iotop/iotop-0.2.1.ebuild,v 1.7 2009/07/13 14:54:54 josejx Exp $

EAPI=2

inherit distutils linux-info

DESCRIPTION="Iotop has a top-like UI used to show which process is using the I/O."
HOMEPAGE="http://guichaz.free.fr/iotop/"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~sparc x86"
IUSE=""
RDEPEND=">=dev-lang/python-2.5[ncurses]"
DEPEND="${RDEPEND}"
CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASKSTATS"
DOCS="THANKS"

src_install() {
	distutils_src_install
	doman iotop.1
}
