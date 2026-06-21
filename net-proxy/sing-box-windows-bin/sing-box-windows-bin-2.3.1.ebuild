# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN="${PN%-bin}"

DESCRIPTION="Modern sing-box desktop client"
HOMEPAGE="https://github.com/xinggaoya/sing-box-windows"
SRC_URI="amd64? (
	https://github.com/xinggaoya/sing-box-windows/releases/download/v${PV}/${MY_PN}_${PV}_amd64.AppImage
		-> ${P}_amd64.AppImage
)"

S="${WORKDIR}"

LICENSE="GPL-3+ MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip"

RDEPEND="
	sys-fs/fuse:0
"

QA_PREBUILT="usr/bin/${MY_PN}"

src_unpack() {
	cp "${DISTDIR}/${P}_amd64.AppImage" "${MY_PN}" || die
	chmod +x "${MY_PN}" || die
	./"${MY_PN}" --appimage-extract >/dev/null || die
}

src_install() {
	dobin "${MY_PN}"

	sed \
		-e 's|^Categories=.*|Categories=Network;|' \
		-e "s|^Comment=.*|Comment=${DESCRIPTION}|" \
		"squashfs-root/usr/share/applications/${MY_PN}.desktop" \
		> "${T}/${MY_PN}.desktop" || die
	domenu "${T}/${MY_PN}.desktop"

	for size in 32 128; do
		doicon -s ${size} "squashfs-root/usr/share/icons/hicolor/${size}x${size}/apps/${MY_PN}.png"
	done
	doicon -s 256 "squashfs-root/usr/share/icons/hicolor/256x256@2/apps/${MY_PN}.png"
}
