# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-manager/virt-manager-0.8.0.ebuild,v 1.2 2009/08/02 14:15:52 cardoe Exp $

EAPI=2

# Stop gnome2.eclass from doing stuff on USE=debug
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A graphical tool for administering virtual machines (KVM/Xen)"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring +network"
RDEPEND=">=dev-lang/python-2.4.0
	>=dev-python/pygtk-1.99.12
	>=app-emulation/libvirt-0.4.5
	>=dev-libs/libxml2-2.6.23[python]
	>=app-emulation/virtinst-0.500.0
	>=gnome-base/librsvg-2
	>=x11-libs/vte-0.12.2[python]
	>=net-libs/gtk-vnc-0.3.4[python]
	>=dev-python/dbus-python-0.61
	>=dev-python/gconf-python-1.99.11
	dev-python/libgnome-python
	gnome-keyring? ( dev-python/gnome-keyring-python )
	network? ( net-firewall/iptables )"
DEPEND="${RDEPEND}
	app-text/rarian"
