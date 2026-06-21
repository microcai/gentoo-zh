# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

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
	app-shells/bash
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/gmp
	dev-libs/libgpg-error
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libglvnd[X]
	media-libs/mesa[gbm(+)]
	sys-fs/e2fsprogs
	virtual/zlib
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/${P}_amd64.AppImage" "${MY_PN}.AppImage" || die
	chmod +x "${MY_PN}.AppImage" || die
	./"${MY_PN}.AppImage" --appimage-extract >/dev/null || die
}

src_install() {
	insinto "/opt/${PN}"
	doins -r squashfs-root/*
	fperms +x \
		"/opt/${PN}/AppRun" \
		"/opt/${PN}/AppRun.wrapped" \
		"/opt/${PN}/usr/bin/${MY_PN}" \
		"/opt/${PN}/usr/lib/${MY_PN}/kernel/linux/amd64/sing-box"
	make_wrapper "${MY_PN}" "/opt/${PN}/AppRun"

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
