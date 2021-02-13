# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="shadowsocksR plugin for Qv2ray to support SSR connection in Qv2ray"
HOMEPAGE="https://github.com/Qv2ray/QvPlugin-SSR"
EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_SUBMODULES=( '*' '-*/libsodium' '-*/libuv' )
EGIT_BRANCH=dev

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	=net-proxy/qv2ray-99999
	dev-libs/libuv
	dev-libs/libsodium
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DSSR_UVW_WITH_QT=1
		-DUSE_SYSTEM_SODIUM=ON
		-DUSE_SYSTEM_LIBUV=ON
		-DSTATIC_LINK_LIBUV=OFF
		-DSTATIC_LINK_SODIUM=OFF
	)
	cmake-utils_src_configure
}

src_install(){
	insinto "/usr/share/qv2ray/plugins"
	insopts -m755
	doins "${BUILD_DIR}/libQvPlugin-SSR.so"
}
