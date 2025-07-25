# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker xdg

DESCRIPTION="Tencent videos"
HOMEPAGE="https://v.qq.com/download.html#linux"
SRC_URI="https://dldir1.qq.com/qqtv/linux/Tenvideo_universal_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="tenvideo-privacy"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
"

QA_PREBUILT="*"

src_install() {
	sed -i 's/腾讯视频/tenvideo/g' "${S}"/usr/share/applications/TencentVideo.desktop || die
	insinto /usr/share
	doins -r "${S}"/usr/share/{applications,icons}

	insinto /opt/tenvideo
	doins -r "${S}"/opt/腾讯视频/*

	fperms 0755 /opt/tenvideo/TencentVideo
	fperms 4755 /opt/tenvideo/chrome-sandbox
}
