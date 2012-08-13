# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
EGIT_REPO_URI="git://github.com/lotem/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-i18n/ibus
	app-i18n/librime
	x11-libs/libnotify
	"
DEPEND="${RDEPEND}
	dev-util/cmake"

src_prepare() {
	sed -i -e 's|rime-data|rime/data|g' \
		package/archlinux/ibus-rime/ChangeLog \
		package/archlinux/librime/librime.install \
		rime_main.c || die
}
