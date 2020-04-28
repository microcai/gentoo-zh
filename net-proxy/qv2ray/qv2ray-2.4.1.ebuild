# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils xdg git-r3

DESCRIPTION="Qt GUI fontend of v2ray"
HOMEPAGE="https://qv2ray.github.io/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT_SUBMODULES=( '*' '-3rdparty/zxing-cpp' '-libs/libqvb' )
EGIT_COMMIT=30a99e596c6bcaac9ac93b8c0c93fe305fc00ea6

KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"
IUSE="libressl"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-libs/grpc
	dev-libs/protobuf
	media-libs/zxing-cpp
"
RDEPEND="
	|| ( net-proxy/v2ray net-proxy/v2ray-bin )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	${DEPEND}
"
BDEPEND="
	dev-qt/linguist-tools:5
"

src_prepare() {
	cmake-utils_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DQV2RAY_DEFAULT_VASSETS_PATH="/usr/bin/v2ray"
		-DQV2RAY_DEFAULT_VCORE_PATH="/usr/bin/v2ray/v2ray"
		-DQV2RAY_DISABLE_AUTO_UPDATE=on
		-DQV2RAY_ZXING_PROVIDER="package"
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
}
