# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcharselect/kcharselect-3.5.9.ebuild,v 1.7 2008/05/18 16:04:51 maekke Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE character selection utility"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

KMEXTRA="charselectapplet/"
