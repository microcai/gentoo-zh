# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg
MY_PN="lx-music-desktop"
DESCRIPTION="一个基于 electron 的音乐软件"
HOMEPAGE="https://github.com/lyswhut/lx-music-desktop"
SRC_URI="
	amd64? ( https://github.com/lyswhut/lx-music-desktop/releases/download/v${PV}/lx-music-desktop-v${PV}-x64.deb \
		-> ${MY_PN}-${PV}-x64.deb )
	arm64? ( https://github.com/lyswhut/lx-music-desktop/releases/download/v${PV}/lx-music-desktop-v${PV}-arm64.deb \
		-> ${MY_PN}-${PV}-arm64.deb )
"
LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="-* ~amd64 ~arm64"
RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	dev-libs/libappindicator:3
	app-accessibility/at-spi2-core[X]
	app-crypt/libsecret
	x11-libs/libnotify
"
S="${WORKDIR}"
src_install() {
	insinto /opt
	doins -r opt/*
	fperms +x /opt/${MY_PN}/${MY_PN}
	dosym -r /opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
	gzip -d usr/share/doc/${MY_PN}/*.gz || die
	dodoc usr/share/doc/${MY_PN}/*
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/lx-music-desktop.png
	domenu usr/share/applications/lx-music-desktop.desktop
}
