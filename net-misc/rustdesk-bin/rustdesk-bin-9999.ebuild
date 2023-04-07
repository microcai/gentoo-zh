# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd desktop xdg

# MY_PV=1.2.0
DESCRIPTION="Open source virtual / remote desktop infrastructure for everyone"
HOMEPAGE="https://rustdesk.com/"
# SRC_URI="https://github.com/rustdesk/rustdesk/releases/download/nightly/rustdesk-${MY_PV}-0-x86_64.pkg.tar.zst -> ${P}.pkg.tar.zst"

LICENSE="AGPL-3"
SLOT="0"
RESTRICT="mirror strip network-sandbox"
KEYWORDS=""

IUSE="wayland"

RDEPEND="
	media-libs/alsa-lib
	x11-libs/gtk+:3
	x11-libs/libxcb
	x11-libs/libXfixes
	media-sound/pulseaudio
	x11-misc/xdotool
	media-libs/libva
	wayland? ( media-video/pipewire[gstreamer] )
"
BDEPEND="
	app-arch/libarchive[zstd]
	app-misc/jq
"
S=${WORKDIR}

src_unpack() {
	DOWNLOAD_URL="$(curl -sL https://api.github.com/repos/rustdesk/rustdesk/releases |
		jq -r ".[0].assets[0].browser_download_url" || die)"
	wget "$DOWNLOAD_URL" -O "${P}".tar.zst || die
	bsdtar xvf "${P}".tar.zst -C "${WORKDIR}" || die
}

src_install() {
	cp -R usr "${D}" || die
	sed -i "s/^\(Icon=\).*$/\1rustdesk/" usr/share/rustdesk/files/rustdesk.desktop || die
	sed -i "s/Other/Network/g" usr/share/rustdesk/files/rustdesk.desktop || die
	systemd_dounit usr/share/rustdesk/files/rustdesk.service
	doicon -s 256 usr/share/rustdesk/files/rustdesk.png
	domenu usr/share/rustdesk/files/rustdesk.desktop
	rm -rf "${D}"/usr/share/rustdesk/files/rustdesk.{service,desktop,png} || die
	rm "${P}".tar.zst || die
}
