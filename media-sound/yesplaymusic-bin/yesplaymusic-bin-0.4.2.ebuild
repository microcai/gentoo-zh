# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A third party music player for Netease Music"
HOMEPAGE="https://github.com/qier222/YesPlayMusic"
BASE_URI="https://github.com/qier222/YesPlayMusic/releases/download/v${PV}"
SRC_URI="${BASE_URI}/yesplaymusic-${PV}.pacman"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

QA_PRESTRIPPED="*"

DEPEND="
	app-arch/gzip
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	x11-libs/gtk+:*
	x11-libs/libxkbcommon"

RDEPEND="
	${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="
	opt/YesPlayMusic/chrome-sandbox
	opt/YesPlayMusic/libEGL.so
	opt/YesPlayMusic/libGLESv2.so
	opt/YesPlayMusic/libffmpeg.so
	opt/YesPlayMusic/libvk_swiftshader.so
	opt/YesPlayMusic/libvulkan.so.1
	opt/YesPlayMusic/swiftshader/libEGL.so
	opt/YesPlayMusic/swiftshader/libGLESv2.so
	opt/YesPlayMusic/yesplaymusic
"

src_unpack(){
	tar xvf "${DISTDIR}/yesplaymusic-${PV}.pacman" || die
}

src_install(){
	insinto "/opt"
	doins -r "${S}/opt/YesPlayMusic"
	for si in 16 24 32 48 64 128 256 512; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/${PN%-bin}.png
	done
	domenu "${FILESDIR}/${PN%-bin}.desktop"
	fperms 0755 "/opt/YesPlayMusic/yesplaymusic"
}
