# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="${PN/-bin/}"
D_PN="youtube-music-desktop-app"
MY_PR="${PR/r/}"
MY_P="${D_PN}-${PVR}"

DESCRIPTION="A Desktop App for YouTube Music"
HOMEPAGE="https://github.com/ytmdesktop/ytmdesktop"
SRC_URI="https://github.com/ytmdesktop/ytmdesktop/releases/download/v${PV}/${D_PN}_${PV}_amd64.deb -> ${MY_P}.deb"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
		app-accessibility/at-spi2-core:2
		app-crypt/libsecret
		dev-libs/nss
		x11-misc/xdg-utils
		x11-libs/gtk+:3
		x11-libs/libnotify
		x11-libs/libXtst
"

RESTRICT="mirror"

QA_PREBUILT="
	chrome-sandbox
	chrome_crashpad_handler
	libEGL.so
	libffmpeg.so
	libGLESv2.so
	libvk_swiftshader.so
	libvulkan.so.1
	${D_PN}
"

src_install() {
	insinto /opt/"${MY_PN}"
	doins -r usr/lib/${D_PN}/*

	doicon usr/share/pixmaps/"${D_PN}".png

	make_desktop_entry "/opt/${MY_PN}/${D_PN}" "YouTube Music Desktop App" "${D_PN}" "AudioVideo;Audio;"

	make_desktop_entry "/opt/${MY_PN}/${D_PN} --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime" "YouTube Music Desktop App Wayland" "${D_PN}" "AudioVideo;Audio;"

	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/opt/${MY_PN}/${f}"
	done

	fperms u+s /opt/"${MY_PN}"/chrome-sandbox
}
