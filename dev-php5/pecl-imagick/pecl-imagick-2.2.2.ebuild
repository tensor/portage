# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-imagick/pecl-imagick-2.2.2.ebuild,v 1.1 2009/04/09 10:36:30 hoffie Exp $

PHP_EXT_NAME="imagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP wrapper for the ImageMagick library."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"

DEPEND=">=media-gfx/imagemagick-6.2.4"
RDEPEND="${DEPEND}"

need_php_by_category
my_conf="--with-imagick=/usr"
