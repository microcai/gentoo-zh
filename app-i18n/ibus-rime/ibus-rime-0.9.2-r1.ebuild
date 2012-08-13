# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit vcs-snapshot

DESCRIPTION="Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="https://github.com/lotem/${PN}/tarball/rime-${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="primaryuri"

RDEPEND="
	app-i18n/ibus
	app-i18n/librime
	x11-libs/libnotify
	"
DEPEND="${RDEPEND}
	dev-util/cmake"

RDEPEND="$RDEPEND
	app-i18n/brise"

src_prepare() {
	sed -i -e 's|rime-data|rime/data|g' \
		package/archlinux/ibus-rime/ChangeLog \
		package/archlinux/librime/librime.install \
		rime_main.c || die
}
