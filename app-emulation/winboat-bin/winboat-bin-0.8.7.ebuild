# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker

DESCRIPTION="Run Windows apps on Linux with seamless integration"
HOMEPAGE="https://www.winboat.app/"
SRC_URI="https://github.com/TibixDev/winboat/releases/download/v${PV}/winboat-${PV}-amd64.deb"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="
	app-containers/docker
	app-containers/docker-compose
	dev-libs/nspr
	dev-libs/nss
	net-misc/freerdp:3
	virtual/libudev
"

src_prepare() {
	default

	local pre="${S}/opt/winboat/resources/app.asar.unpacked/node_modules/usb/prebuilds"
	if [[ -d ${pre} ]]; then
		rm -rf \
			"${pre}/android-arm" \
			"${pre}/android-arm64" \
			"${pre}/linux-ia32" \
			"${pre}/linux-arm" \
			"${pre}/linux-arm64" || die "failed to prune non-amd64 prebuilds"

		rm -f "${pre}/linux-x64/"*musl* || true
	fi
}

src_install() {
	insinto /opt/winboat
	doins -r "${S}"/opt/winboat/*
	fperms +x /opt/winboat/winboat
	fperms +x /opt/winboat/chrome-sandbox
	fperms +x /opt/winboat/chrome_crashpad_handler
	domenu "${S}/usr/share/applications/winboat.desktop"
	for size in 16 32 48 64 128 256 512; do
		doicon -s "${size}" "${S}/usr/share/icons/hicolor/${size}x${size}/apps/winboat.png"
	done
}
