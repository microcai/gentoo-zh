# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PV=$(ver_cut 1-3)-$(ver_cut 4).$(ver_cut 5)

DESCRIPTION="Next generation information browser"
HOMEPAGE="
	https://follow.is/
	https://github.com/RSSNext/Follow
"
SRC_URI="
	https://github.com/RSSNext/Follow/releases/download/v${MY_PV}/Follow-${MY_PV}-linux-x64.AppImage -> ${P}.AppImage
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	x11-libs/gtk+:3[X,cups]
	x11-libs/libxkbcommon
"

src_unpack() {
	mkdir -p "${S}" || die
	cp "${DISTDIR}/${P}.AppImage" "${S}" || die

	cd "${S}" || die         # "appimage-extract" unpacks to current directory.
	chmod +x "${S}/${P}.AppImage" || die
	"${S}/${P}.AppImage" --appimage-extract || die
}

src_install() {
	cd "${S}/squashfs-root" || die

	domenu Follow.desktop
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/Follow.png

	local toremove=(
		.DirIcon
		Follow.desktop
		Follow.png
		AppRun
		LICENSES.chromium.html
		usr
	)
	rm -f -r "${toremove[@]}" || die

	local apphome="/opt/${PN}"
	insinto "${apphome}"
	doins -r .

	fperms +x "${apphome}/Follow"
	dosym -r "${apphome}/Follow" "/opt/bin/Follow"
}
