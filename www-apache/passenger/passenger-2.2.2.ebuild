# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/passenger/passenger-2.2.2.ebuild,v 1.2 2009/05/19 21:23:27 flameeyes Exp $

inherit apache-module flag-o-matic ruby

DESCRIPTION="Passenger (a.k.a. mod_rails) makes deployment of Ruby on Rails applications a breeze"
HOMEPAGE="http://modrails.com/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

CDEPEND=">=dev-lang/ruby-1.8.5
	>=dev-ruby/rubygems-0.9.0
	>=dev-ruby/rake-0.8.1
	>=dev-ruby/fastthread-1.0.1
	>=dev-ruby/rails-1.2.0
	>=dev-ruby/rack-1.0.0"
DEPEND="${CDEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${CDEPEND}"

APACHE2_MOD_FILE="${S}/ext/apache2/mod_${PN}.so"
APACHE2_MOD_CONF="30_mod_${PN}-2.0.1 30_mod_${PN}"
APACHE2_MOD_DEFINE="PASSENGER"

need_apache2_2

pkg_setup() {
	use debug && append-flags -DPASSENGER_DEBUG
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	rm -f bin/passenger-install-apache2-module
	sed -i -e '473s/, :doc//' Rakefile
}

src_compile() {
	APXS2="${APXS}" \
	HTTPD="${APACHE_BIN}" \
	rake apache2 native_support || die "rake failed"

	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

src_install() {
	DISTDIR="${D}" \
	rake fakeroot || die "rake failed"

	apache-module_src_install
}
