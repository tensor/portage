# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/policykit/policykit-0.92.ebuild,v 1.2 2009/07/06 10:53:44 alexxy Exp $

EAPI="2"

inherit autotools eutils multilib pam

MY_PN="polkit"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Policy framework for controlling privileges for system-wide services"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
IUSE="debug doc expat pam zsh-completion nls"

RDEPEND=">=dev-libs/glib-2.14
	>=dev-libs/eggdbus-0.4
	expat? ( dev-libs/expat )
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.36
	>=dev-util/gtk-doc-am-1.10-r1
	doc? ( >=dev-util/gtk-doc-1.10 )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewuser polkituser -1 "-1" /dev/null polkituser
}

src_prepare() {
	# Add zsh completions
	if use zsh-completion; then
		epatch "${FILESDIR}/${P}-zsh-completions.patch"
	fi

	# Don't force user to use --as-needed LDFLAGS
	epatch "${FILESDIR}/${P}-as-needed.patch"
	eautoreconf
}

src_configure() {

	local conf=

	if use pam ; then
		conf="--with-authfw=pam --with-pam-module-dir=$(getpam_mod_dir)"
	else
		conf="--with-authfw=none"
	fi

	if use expat; then
		conf="--with-expat=/usr"
	fi

	econf ${conf} \
		--enable-fast-install \
		--enable-libtool-lock \
		--enable-man-pages \
		--disable-dependency-tracking \
		--with-os-type=gentoo \
		--with-polkit-user=polkituser \
		--localstatedir=/var \
		$(use_enable debug verbose-mode) \
		$(use_enable doc gtk-doc) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc NEWS README AUTHORS ChangeLog || die "dodoc failed"

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins "${S}/tools/_polkit" || die "zsh completion died"
		doins "${S}/tools/_polkit_auth" || die "zsh completion died"
		doins "${S}/tools/_polkit_action" || die "zsh completion died"
	fi

	einfo "Installing basic PolicyKit.conf"
	insinto /etc/PolicyKit
	doins "${FILESDIR}"/PolicyKit.conf || die "doins failed"
	# Need to keep a few directories around...

	diropts -m0770 -o root -g polkituser
	keepdir /var/run/PolicyKit
	keepdir /var/lib/PolicyKit
}

pkg_preinst() {
	# Stolen from vixie-cron ebuilds
	has_version "<${CATEGORY}/${PN}-0.9"
	fix_var_dir_perms=$?
}

pkg_postinst() {
	# bug #239231
	if [[ $fix_var_dir_perms = 0 ]] ; then
		echo
		ewarn "Previous version of PolicyKit handled /var/run and /var/lib"
		ewarn "with different permissions. Proper permissions are"
		ewarn "now being set on ${ROOT}var/lib/PolicyKit and ${ROOT}var/lib/PolicyKit"
		ewarn "Look at these directories if you have a specific configuration"
		ewarn "that needs special ownerships or permissions."
		echo
		chmod 0770 "${ROOT}"var/{lib,run}/PolicyKit || die "chmod failed"
		chgrp -R polkituser "${ROOT}"var/{lib,run}/PolicyKit || die "chgrp failed"
	fi
}
