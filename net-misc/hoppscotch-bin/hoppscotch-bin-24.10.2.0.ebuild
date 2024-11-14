# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Open source API development ecosystem"
HOMEPAGE="https://hoppscotch.io"
SRC_URI="https://github.com/hoppscotch/releases/releases/download/v$(ver_rs 3 '-')/Hoppscotch_linux_x64.deb"

S="${WORKDIR}"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/webkit-gtk:4"

RESTRICT="strip mirror"

src_install() {
	dobin "${S}"/usr/bin/hoppscotch

	domenu "${S}"/usr/share/applications/hoppscotch.desktop

	for size in 32 128; do
		doicon -s ${size} "${S}"/usr/share/icons/hicolor/${size}x${size}/apps/hoppscotch.png
	done
	doicon -s 256 "${S}"/usr/share/icons/hicolor/256x256@2/apps/hoppscotch.png
}
