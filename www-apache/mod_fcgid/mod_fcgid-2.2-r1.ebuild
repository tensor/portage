# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fcgid/mod_fcgid-2.2-r1.ebuild,v 1.1 2009/07/24 12:14:33 hollow Exp $

inherit apache-module eutils multilib

DESCRIPTION="mod_fcgid is a binary-compatible alternative to mod_fastcgi with better process management."
HOMEPAGE="http://fastcgi.coremail.cn/"
SRC_URI="mirror://sourceforge/mod-fcgid/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}.${PV}"

APACHE2_MOD_CONF="${PV}/20_${PN}"
APACHE2_MOD_DEFINE="FCGID"

APXS2_ARGS="-I ${S} -c ${PN}.c fcgid_bridge.c \
			fcgid_conf.c fcgid_pm_main.c \
			fcgid_spawn_ctl.c mod_fcgid.rc fcgid_bucket.c \
			fcgid_filter.c fcgid_protocol.c \
			arch/unix/fcgid_pm_unix.c \
			arch/unix/fcgid_proctbl_unix.c \
			arch/unix/fcgid_proc_unix.c"

DOCFILES="AUTHOR ChangeLog"

need_apache2_2

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-vhost-granularity.patch
}
