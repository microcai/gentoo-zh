# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson ninja-utils git-r3

EGIT_REPO_URI="https://github.com/Genymobile/scrcpy.git"

if [[ ${PV} = 9999* ]]; then
	MY_SERVER_PV="1.3"
else
	EGIT_COMMIT="v${PV}"
	MY_SERVER_PV="${PV}"
	KEYWORDS="~amd64"
fi

MY_SERVER_PN="scrcpy-server"
MY_SERVER_P="${MY_SERVER_PN}-v${MY_SERVER_PV}"

SRC_URI="https://github.com/Genymobile/${PN}/releases/download/v${MY_SERVER_PV}/${MY_SERVER_P}"

DESCRIPTION="Display and control your Android device"
HOMEPAGE="https://blog.rom1v.com/2018/03/introducing-scrcpy/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RESTRICT="test"

COMMON_DEPEND="media-libs/libsdl2
	media-video/ffmpeg"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"
PDEPEND=""

src_configure() {
	local emesonargs=(
		-Db_lto=true
		-Dprebuilt_server="${DISTDIR}/${MY_SERVER_P}"
	)
	meson_src_configure
}
