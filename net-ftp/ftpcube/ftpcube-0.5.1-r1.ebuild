# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.5.1-r1.ebuild,v 1.3 2008/02/15 16:59:03 jer Exp $

inherit distutils

MY_P="${P/_beta/-b}"
DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${MY_P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"

KEYWORDS="~amd64 hppa ~ppc sparc x86"
SLOT="0"
LICENSE="Artistic"
IUSE="sftp"

DEPEND="=dev-python/wxpython-2.6*
	sftp? ( dev-python/paramiko )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-wxversion.patch"
}

src_install() {
	distutils_src_install --install-scripts=/usr/bin
}
