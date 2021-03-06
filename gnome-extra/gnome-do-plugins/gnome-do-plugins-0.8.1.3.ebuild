# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do-plugins/gnome-do-plugins-0.8.1.3.ebuild,v 1.1 2009/03/17 20:30:27 graaff Exp $

inherit eutils autotools gnome2 mono versionator

MY_PN="do-plugins"
PVC=$(get_version_component_range 1-3)

DESCRIPTION="Plugins to put the Do in Gnome Do"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/${MY_PN}/0.8/${PVC}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="banshee evo"

RDEPEND=">=gnome-extra/gnome-do-${PV}
		dev-dotnet/wnck-sharp
		banshee? ( >=media-sound/banshee-1.4.2 )
		evo? ( dev-dotnet/evolution-sharp )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/monodevelop"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -r -e "/(FLICKR|Flickr)/d" configure.ac Makefile.am
	use banshee || sed -i -r -e "/(BANSHEE|Banshee)/d" configure.ac Makefile.am
	use evo     || sed -i -r -e "/(EVOLUTION|Evolution)/d" configure.ac Makefile.am
	eautoreconf
}

src_compile()
{
	econf --enable-debug=no --enable-release=yes || die "configure failed"
	# The make system is unfortunately broken for parallel builds and
	# upstream indicated on IRC that they have no intention to fix
	# that.
	emake -j1 || die "make failed"
}

pkg_postinst()
{
	ewarn "Plugin handling has changed since gnome-do 0.4."
	ewarn "If you install the gnome-do-plugins package you will have local copies"
	ewarn "of the plugins, but you still need to manually enable them in Preferences."
	ewarn "Also note that plugins installed from upstream may not be compatible with"
	ewarn "your system. When in doubt check the output from gnome-do itself".
	ewarn "Old plugins may not be compatible either."
	ewarn "Check ~/.local/share/gnome-do/ if you have problems with plugins."
}
