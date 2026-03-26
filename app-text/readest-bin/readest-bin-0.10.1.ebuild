# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="A modern, feature-rich ebook reader"
HOMEPAGE="https://readest.com/"
URI_PREFIX="https://github.com/readest/readest/releases/download/v${PV}/Readest_${PV}"
SRC_URI="
	amd64? ( ${URI_PREFIX}_amd64.deb )
"

S="${WORKDIR}"
LICENSE="AGPL-3"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="net-libs/webkit-gtk:4.1"

src_install() {
	dobin "${S}/usr/bin/readest"
	domenu "${S}/usr/share/applications/Readest.desktop"
	for size in 32 128; do
		doicon -s ${size} "${S}/usr/share/icons/hicolor/${size}x${size}/apps/readest.png"
	done
	doicon -s 256 "${S}/usr/share/icons/hicolor/256x256@2/apps/readest.png"
}
