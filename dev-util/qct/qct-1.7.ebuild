# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qct/qct-1.7.ebuild,v 1.1 2009/06/15 20:19:28 yngwin Exp $

EAPI="2"
NEED_PYTHON="2.4"
inherit distutils

DESCRIPTION="PyQt based commit tool for many VCSs"
HOMEPAGE="http://qct.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bazaar cvs mercurial monotone subversion"

DEPEND="app-text/asciidoc
	app-text/xmlto
	dev-python/PyQt4
	bazaar? ( dev-util/bzr )
	cvs? ( dev-util/cvs )
	mercurial? ( dev-util/mercurial )
	monotone? ( dev-util/monotone )
	subversion? ( dev-util/subversion )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	distutils_src_prepare

	rm qctlib/vcs/p4.py

	# support for git requires cogito which isn't in portage
	rm qctlib/vcs/git.py
	rm qctlib/vcs/cg.py

	use bazaar || rm qctlib/vcs/bzr.py
	use cvs || rm qctlib/vcs/cvs.py
	use mercurial || rm qctlib/vcs/hg.py
	use monotone || rm qctlib/vcs/mtn.py
	use subversion || rm qctlib/vcs/svn.py
}

src_install() {
	distutils_src_install

	# needed for $PYVER
	distutils_python_version

	# manpage and html docs are built using asciidoc
	make -C doc man html || die
	doman doc/qct.1 || die
	dohtml doc/qct.1.html || die

	if use bazaar; then
		insinto "$(python_get_sitedir)/bzrlib/plugins" || die
		doins plugins/qctBzrPlugin.py || die
	fi

	if use mercurial; then
		insinto "$(python_get_sitedir)/hgext" || die
		doins hgext/qct.py || die
		insinto /etc/mercurial/hgrc.d || die
		doins "${FILESDIR}/qct.rc" || die
	fi
}
