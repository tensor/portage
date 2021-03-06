# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimcommander/vimcommander-1.54.2.9.ebuild,v 1.6 2008/03/24 17:02:22 coldwind Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Total Commander style file explorer"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=808"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="vimcommander"

function src_unpack() {
	unpack ${A}
	mkdir "${S}"/doc || die "can't make doc dir"

	# This plugin uses an 'automatic documentation install' trick. This
	# causes problems for us during the unmerge. Fortunately, sed can fix
	# this for us.
	sed -e '1,/^=== START_DOC$/d' \
		-e '/^=== END_DOC/,$d' \
		-e "s/#version#/v${PV}/" \
		"${S}"/plugin/vimcommander.vim > "${S}"/doc/vimcommander.txt \
		|| die "help extraction failed"

	echo -ne "\n\n vim:tw=78:ts=8:ft=help:norl:" >> "${S}"/doc/vimcommander.txt

	sed -i -e 's/" \(let b:vimcommander_install_doc=\)[01]/\10/' \
		"${S}"/plugin/vimcommander.vim \
		|| die "help extract disable failed"
}
