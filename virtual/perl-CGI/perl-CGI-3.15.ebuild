# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-CGI/perl-CGI-3.15.ebuild,v 1.13 2009/03/13 20:09:02 tove Exp $

DESCRIPTION="Virtual for CGI"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.8.8 ~perl-core/CGI-${PV} )"
