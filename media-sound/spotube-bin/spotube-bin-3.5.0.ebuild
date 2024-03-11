# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A lightweight Spotify client using YouTube as audio source"
HOMEPAGE="https://github.com/KRTirtho/spotube"
SRC_URI="https://github.com/KRTirtho/spotube/releases/download/v${PV}/spotube-linux-${PV}-x86_64.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/libappindicator
	media-video/mpv
"

S="${WORKDIR}"

src_install() {
	insinto /opt/spotube
	doins -r "${S}/data" "${S}/lib"
	dobin "${S}/spotube"
	insinto /opt/spotube
	doins "${S}/spotube-logo.png"
	sed -i -e 's|^Exec=.*|Exec=/opt/spotube/spotube|' \
		-i -e 's|^Icon=.*|Icon=/opt/spotube/spotube-logo.png|' \
		"${S}"/spotube.desktop || die
	for i in 16 32 64 128 256; do
	    doicon -s "$i" "${S}"/spotube-logo.png
	done
	domenu "${S}/spotube.desktop"
}
