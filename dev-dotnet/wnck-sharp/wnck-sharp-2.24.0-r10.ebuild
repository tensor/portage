# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/wnck-sharp/wnck-sharp-2.24.0-r10.ebuild,v 1.2 2009/03/27 17:09:25 ranger Exp $

EAPI=2

GTK_SHARP_REQUIRED_VERSION="2.12"

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="test"
