# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.16-r4.ebuild,v 1.1 2006/07/15 16:52:38 dang Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="15"
inherit kernel-2
detect_version

UML_VER="uml-2.6.16-bs2"
UNIPATCH_LIST="${DISTDIR}/${UML_VER}.patch.bz2
	${FILESDIR}/${UML_VER}-new-glibc.patch"

DESCRIPTION="Full sources for the User Mode Linux kernel"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI}
	http://www.user-mode-linux.org/~blaisorblade/patches/guest/${UML_VER}/${UML_VER}.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
KEYWORDS="~amd64 ~x86"

K_EXTRAEINFO="Since you are using UML, you may want to read the Gentoo Linux
Developer's guide to system testing with User-Mode Linux that
can be found at http://www.gentoo.org/doc/en/uml.xml"
