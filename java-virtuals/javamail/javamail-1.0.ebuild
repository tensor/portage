# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/javamail/javamail-1.0.ebuild,v 1.2 2007/10/20 10:53:23 fordfrog Exp $

inherit java-virtuals-2

DESCRIPTION="Virtual for javamail implementations"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( dev-java/sun-javamail >=dev-java/gnu-javamail-1.0-r2 )"

JAVA_VIRTUAL_PROVIDES="sun-javamail gnu-javamail-1"
