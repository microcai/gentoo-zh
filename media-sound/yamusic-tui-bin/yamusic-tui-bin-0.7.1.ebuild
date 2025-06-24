# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop
DESCRIPTION="An unofficial Yandex Music terminal client, with offline mode and My Wave"
HOMEPAGE="https://github.com/DECE2183/yamusic-tui"
SRC_URI="https://github.com/DECE2183/yamusic-tui/releases/download/v${PV}/yamusic-nomedia"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"

QA_PREBUILT="*"
# Against "QA Notice: Files built without respecting CFLAGS have been detected"

src_install() {
	newbin "${DISTDIR}/yamusic-nomedia" yamusic-nomedia
	domenu "${FILESDIR}/yamusic-nomedia.desktop"
}

pkg_postinst() {
	einfo "For use, you need a Yandex Music account and access token, read about it https://github.com/DECE2183/yamusic-tui"
}
