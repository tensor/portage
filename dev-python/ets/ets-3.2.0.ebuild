# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ets/ets-3.2.0.ebuild,v 1.1 2009/03/27 10:56:01 bicatali Exp $

EAPI=2

DESCRIPTION="Meta package for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/"

IUSE="doc examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="
	=dev-python/apptools-3.2.0[doc?,examples?]
	=dev-python/blockcanvas-3.0.2
	=dev-python/codetools-3.0.2[doc?,examples?]
	=dev-python/chaco-3.1.0[doc?,examples?]
	=dev-python/enable-3.1.0[examples?]
	=dev-python/enthoughtbase-3.0.2[doc?,examples?]
	=dev-python/envisagecore-3.1.0[doc?,examples?]
	=dev-python/envisageplugins-3.1.0[examples?]
	=dev-python/etsdevtools-3.0.2[doc?,examples?]
	=dev-python/etsprojecttools-0.5.0
	=sci-visualization/mayavi-3.2.0:2[doc?,examples?]
	=dev-python/scimath-3.0.3
	=dev-python/traits-3.1.0[doc?,examples?]
	=dev-python/traitsgui-3.0.4[doc?,examples?]"
