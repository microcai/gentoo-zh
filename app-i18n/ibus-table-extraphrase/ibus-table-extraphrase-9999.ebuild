# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/acevery/${PN}.git"

inherit autotools git

DESCRIPTION="Extra Chinese phrases for IBus-Table based IME"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-i18n/ibus-table"
RDEPEND=""

src_unpack() {
	git_src_unpack
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS README
}

pkg_postinst() {
	echo
	ewarn "Please offer your suggestions or report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	echo
}
