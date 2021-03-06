# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/powerdevil/powerdevil-4.3.0.ebuild,v 1.2 2009/08/10 17:23:57 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +pm-utils"

COMMONDEPEND="
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/solid-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXScrnSaver
"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMONDEPEND}
	!sys-power/powerdevil
"
PDEPEND="pm-utils? ( sys-power/pm-utils )"

KMEXTRACTONLY="
	krunner/
	ksmserver/org.kde.KSMServerInterface.xml
"
