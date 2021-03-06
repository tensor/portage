# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webob/webob-0.9.2.ebuild,v 1.1 2008/07/02 05:09:52 pythonhead Exp $

inherit distutils

MY_PN="WebOb"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WSGI request and response object"
HOMEPAGE="http://pythonpaste.org/webob/"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
S="${WORKDIR}/${MY_P}"
DEPEND="dev-python/setuptools"
RDEPEND=""

#Note: Tests require webtest, but webob is a dependency of webtest
