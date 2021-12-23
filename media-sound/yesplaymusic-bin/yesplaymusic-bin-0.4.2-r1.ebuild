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
QA_PREBUILT="*"
QA_FLAGS_IGNORED="*"

DEPEND="
	app-arch/gzip"

RDEPEND="
	${DEPEND}
	x11-libs/gtk+:*
	dev-libs/nss
	net-dns/c-ares
	media-video/ffmpeg
	net-libs/http-parser
	dev-libs/libappindicator
	dev-libs/libevent
	x11-libs/libnotify
	media-libs/libvpx
	dev-libs/libxslt
	sys-libs/zlib[minizip]
	dev-libs/re2
	app-arch/snappy"

S="${WORKDIR}"

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
