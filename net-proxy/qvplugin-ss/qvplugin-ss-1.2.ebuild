# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="shadowsocks plugin for Qv2ray to support SIP003 in Qv2ray"
HOMEPAGE="https://github.com/Qv2ray/QvPlugin-SS"
EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_SUBMODULES=( '*' '-*/libsodium' '-*/libuv' )
EGIT_COMMIT="v${PV}"

KEYWORDS="amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	<net-proxy/qv2ray-2.7.0
	dev-libs/libuv
	dev-libs/libsodium
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/fix.patch"
)

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
	doins "${BUILD_DIR}/libQvSSPlugin.so"
}
