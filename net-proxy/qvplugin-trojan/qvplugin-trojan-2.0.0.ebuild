# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Plugin for Qv2ray to support Trojan proxy in Qv2ray"
HOMEPAGE="https://github.com/Qv2ray/QvPlugin-Trojan"
EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_SUBMODULES=( '*' '-*/libsodium' '-*/libuv' )
EGIT_COMMIT="v${PV}"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE="tcpfastopen nat reuseport"

DEPEND="
	<net-proxy/qv2ray-2.7.0
	dev-libs/boost
	>=dev-libs/openssl-1.1.1
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DENABLE_SSL_KEYLOG=ON
		-DENABLE_TLS13_CIPHERSUITES=ON
		-DFORCE_TCP_FASTOPEN=$(usex tcpfastopen)
		-DENABLE_NAT=$(usex nat)
		-DENABLE_REUSE_PORT=$(usex reuseport)
	)
	cmake-utils_src_configure
}

src_install(){
	insinto "/usr/share/qv2ray/plugins"
	insopts -m755
	doins "${BUILD_DIR}/libQvTrojanPlugin.so"
}
