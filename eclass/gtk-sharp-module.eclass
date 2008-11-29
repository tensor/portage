# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gtk-sharp-module.eclass,v 1.6 2008/11/28 00:20:08 loki_val Exp $

# Author : Peter Johanson <latexer@gentoo.org>, butchered by ikelos, then loki_val.
# Based off of original work in gst-plugins.eclass by <foser@gentoo.org>

# Note that this breaks compatibility with the original gtk-sharp-component
# eclass.

inherit eutils mono multilib autotools

# Get the name of the component to build and the build dir; by default,
# extract it from the ebuild's name.
GTK_SHARP_MODULE=${GTK_SHARP_MODULE:=${PN/-sharp/}}
GTK_SHARP_MODULE_DIR=${GTK_SHARP_MODULE_DIR:=${PN/-sharp/}}

# In some cases the desired module cannot be configured to be built on its own.
# This variable allows for the setting of additional configure-deps.
GTK_SHARP_MODULE_DEPS="${GTK_SHARP_MODULE_DEPS}"

# Allow ebuilds to set a value for the required GtkSharp version; default to
# ${PV}.
GTK_SHARP_REQUIRED_VERSION=${GTK_SHARP_REQUIRED_VERSION:=${PV%.*}}

# Version number used to differentiate between unversioned 1.0 series and the
# versioned 2.0 series (2.0 series has 2 or 2.0 appended to various paths and
# scripts). Default to ${SLOT}.
GTK_SHARP_SLOT="${GTK_SHARP_SLOT:=${SLOT}}"
GTK_SHARP_SLOT_DEC="${GTK_SHARP_SLOT_DEC:=-${GTK_SHARP_SLOT}.0}"

# Set some defaults.
DESCRIPTION="GtkSharp's ${GTK_SHARP_MODULE} module"
HOMEPAGE="http://www.mono-project.com/GtkSharp"

LICENSE="LGPL-2.1"

DEPEND="=dev-dotnet/gtk-sharp-${GTK_SHARP_REQUIRED_VERSION}*
	>=sys-apps/sed-4
	>=dev-util/pkgconfig-0.23"
RDEPEND="=dev-dotnet/gtk-sharp-${GTK_SHARP_REQUIRED_VERSION}*"

RESTRICT="test"

# The GtkSharp modules are currently divided into three seperate tarball
# distributions. Figure out which of these our component belongs to. This is
# done to avoid passing bogus configure parameters, as well as to return the
# correct tarball to download. Note that this makes ${GTK_SHARP_TARBALL_PREFIX}
# obsolete.
gnome_sharp_module_list="art gnome gnomevfs"
gnome_desktop_sharp_module_list="gnome-print gnome-panel gtkhtml gtksourceview nautilusburn rsvg vte wnck"

if [[ " ${gnome_sharp_module_list} " == *" ${GTK_SHARP_MODULE} "* ]] ; then
	my_module_list="${gnome_sharp_module_list}"
	my_tarball="gnome-sharp"

# While gnome-desktop-sharp is a part of gnome-desktop-sharp (0_o) it is not a
# configurable component, so we don't want to put it into the module list.
# Result is that we have to check for it manually here and in src_configure.
elif [[ " ${gnome_desktop_sharp_module_list} " == *" ${GTK_SHARP_MODULE} "* ||
		"${GTK_SHARP_MODULE}" == "gnome-desktop" ]] ; then
	my_module_list="${gnome_desktop_sharp_module_list}"
	my_tarball="gnome-desktop-sharp"
else
	die "unknown GtkSharp module: ${GTK_SHARP_MODULE}"
fi

MY_P=${my_tarball}-${PV}
S=${WORKDIR}/${MY_P}

# Since all interesting versions are hosted on the GNOME server anyway it's the
# only one we support, for now.
SRC_URI="mirror://gnome/sources/${my_tarball}/${PV%.*}/${MY_P}.tar.bz2
		mirror://gentoo/${MY_P}-configurable.diff.gz
		http://dev.gentoo.org/~ikelos/devoverlay-distfiles/${MY_P}-configurable.diff.gz"


### Public functions.

gtk-sharp-module_fix_files() {
	# Change references like "/r:../art/art-sharp.dll" ->
	# "/r:/usr/lib/pkgconfig/../../lib/mono/gtk-sharp-2.0/art-sharp.dll" and references like
	# "../glib/glib-sharp.xml" or "$(top_srcdir)/glib/glib-sharp.xml" ->
	# "${gapi_dir}/glib-sharp.xml".
	#
	# We also make sure to call the installed gapi-fixup and gapi-codegen and
	# not the ones that would be built locally.
	local gapi_dir="${ROOT}/usr/share/gapi${GTK_SHARP_SLOT_DEC}"

	local makefiles=( $(find "${S}" -name Makefile.in) )
	sed -i \
		-e "s;\(\.\.\|\$(top_srcdir)\)/[[:alpha:]]*/\([[:alpha:]]*\(-[[:alpha:]]*\)*\).xml;${gapi_dir}/\2.xml;g" \
		-e "s; \.\./art/art-sharp.dll; $(get_sharp_lib art-sharp-2.0);g" \
		-e "s;\.\./gnomevfs/gnome-vfs-sharp.dll;$(get_sharp_lib gnome-vfs-sharp-2.0);g" \
		-e "s;\$(top_builddir)/art/art-sharp.dll;$(get_sharp_lib art-sharp-2.0);" \
		-e "s;\$(top_builddir)/gnome/gnome-sharp.dll;$(get_sharp_lib gnome-sharp-2.0);" \
		"${makefiles[@]}" || die "failed to fix GtkSharp makefiles"
}

get_sharp_lib() {
	S="$(pkg-config --libs ${1})"
	S=${S%% *}
	printf ${S#-r:}
}

gtk-sharp-module_src_prepare() {
	# Make selecting components configurable.
	epatch "${WORKDIR}/${MY_P}-configurable.diff"

	# Disable building samples, #16015.
	sed -i -e "s:sample::" "${S}/Makefile.am" || die

	eautoreconf

	cd "${S}/${GTK_SHARP_MODULE_DIR}"

	gtk-sharp-module_fix_files
}

gtk-sharp-module_src_configure() {
	# Disable any module besides one(s) we want.
	local module gtk_sharp_conf

	einfo "Configuring to build ${PN} module ..."

	# No bogus configure parameters please.
	[[ ${GTK_SHARP_MODULE} == "gnome-desktop" ]] && GTK_SHARP_MODULE=

	for module in ${GTK_SHARP_MODULE} ${GTK_SHARP_MODULE_DEPS} ; do
		my_module_list=${my_module_list/${module}/}
	done
	for module in ${my_module_list} ; do
		gtk_sharp_conf="${gtk_sharp_conf} --disable-${module} "
	done
	for module in ${GTK_SHARP_MODULE} ${GTK_SHARP_MODULE_DEPS} ; do
		gtk_sharp_conf="${gtk_sharp_conf} --enable-${module} "
	done

	cd "${S}"
	econf ${@} ${gtk_sharp_conf} || die "econf failed"
}

gtk-sharp-module_src_compile() {

	cd "${S}/${GTK_SHARP_MODULE_DIR}"
	LANG=C emake || die "emake failed"
}

gtk-sharp-module_src_install() {
	cd "${GTK_SHARP_MODULE_DIR}"
	LANG=C emake DESTDIR=${D} install || die "emake install failed"
}

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install
