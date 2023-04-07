# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd desktop xdg

DESCRIPTION="Open source virtual / remote desktop infrastructure for everyone"
HOMEPAGE="https://rustdesk.com/"
SRC_URI="https://github.com/rustdesk/rustdesk/releases/download/${PV}/rustdesk-${PV}-manjaro-arch.pkg.tar.zst -> ${P}.pkg.tar.zst"

LICENSE="AGPL-3"
SLOT="0"
RESTRICT="mirror strip"
KEYWORDS="amd64"

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
BDEPEND="app-arch/libarchive[zstd]"
S=${WORKDIR}

src_unpack() {
	bsdtar xvf "${DISTDIR}"/"${P}".pkg.tar.zst -C "${WORKDIR}" || die
}

src_prepare() {
	sed -i "s/^\(Icon=\).*$/\1rustdesk/" usr/share/rustdesk/files/rustdesk.desktop || die
	sed -i "s/Other/Network/g" usr/share/rustdesk/files/rustdesk.desktop || die
	default
}

src_install() {
	dobin usr/bin/rustdesk
	insinto /usr/lib/rustdesk/
	doins usr/lib/rustdesk/libsciter-gtk.so
	fperms +x /usr/lib/rustdesk/libsciter-gtk.so
	insinto /usr/share/rustdesk/files/
	doins usr/share/rustdesk/files/pynput_service.py
	doicon -s 256 usr/share/rustdesk/files/rustdesk.png
	domenu usr/share/rustdesk/files/rustdesk.desktop
	systemd_dounit usr/share/rustdesk/files/rustdesk.service
}
