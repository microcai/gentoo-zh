# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3

DESCRIPTION="Rime Input Method Engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/rimeime/"
EGIT_REPO_URI="https://github.com/lotem/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="app-i18n/ibus
	app-i18n/librime
	x11-libs/libnotify"
DEPEND="${COMMON_DEPEND}
	dev-util/cmake"
RDEPEND="${COMMON_DEPEND}
	app-i18n/rime-data"

src_prepare() {
	sed -i -e "/libexecdir/s:/usr/lib:/usr/libexec:" Makefile || die
	sed -i -e "/exec/s:/usr/lib:/usr/libexec:" rime.xml || die
}
