# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plugin for Qv2ray to support SIP003 in Qv2ray"
HOMEPAGE="https://github.com/Qv2ray/QvPlugin-SS"
GIT_COMMIT_QVPLUGIN_INTERFACE="911c4adbb7b598435162da245ab248d215d3f018"
GIT_COMMIT_QJSONSTRUCT="02416895f2f1fb826f8e9207d8bbe5804b6d0441"
GIT_COMMIT_SHADOWSOCKS_UVW="c731a8aa06d7bf560e772e6ab1b41d679a1136a2"
SRC_URI="
	https://github.com/Qv2ray/QvPlugin-SS/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Qv2ray/QvPlugin-Interface/archive/${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
		-> QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
	https://github.com/Qv2ray/QJsonStruct/archive/${GIT_COMMIT_QJSONSTRUCT}.tar.gz
		-> QJsonStruct-${GIT_COMMIT_QJSONSTRUCT}.tar.gz
	https://github.com/Qv2ray/shadowsocks-uvw/archive/${GIT_COMMIT_SHADOWSOCKS_UVW}.tar.gz
		-> shadowsocks-uvw-${GIT_COMMIT_SHADOWSOCKS_UVW}.tar.gz
"

S="${WORKDIR}/QvPlugin-SS-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,network,widgets]
	dev-libs/libuv:=
	dev-libs/libsodium:=
	net-libs/mbedtls:0=
	dev-libs/openssl:0=
"
RDEPEND="
	>=net-proxy/qv2ray-2.7.0
	${DEPEND}
"

src_unpack() {
	default
	rmdir "${S}/interface" || die
	mv "${WORKDIR}/QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}" "${S}/interface" || die
	cd "${S}/3rdparty" || die
	rmdir QJsonStruct shadowsocks-uvw || die
	mv "${WORKDIR}/QJsonStruct-${GIT_COMMIT_QJSONSTRUCT}" QJsonStruct || die
	mv "${WORKDIR}/shadowsocks-uvw-${GIT_COMMIT_SHADOWSOCKS_UVW}" shadowsocks-uvw || die
}

src_prepare() {
	sed -i -e 's/32768 >= MINSIGSTKSZ ? 32768 : MINSIGSTKSZ/32768/' test/catch.hpp || die
	sed -i -e '5c add_library(LIBBLOOM STATIC ${BLOOM_SOURCE})' 3rdparty/shadowsocks-uvw/cmake/libbloom.cmake || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQVPLUGIN_USE_QT6=ON
		-DSSR_UVW_WITH_QT=1
		-DUSE_SYSTEM_LIBUV=ON
		-DUSE_SYSTEM_SODIUM=ON
		-DSTATIC_LINK_LIBUV=OFF
		-DSTATIC_LINK_SODIUM=OFF
		-DUSE_SYSTEM_MBEDTLS=ON
	)
	cmake_src_configure
}

src_install(){
	insinto "/usr/share/qv2ray/plugins"
	insopts -m755
	doins "${BUILD_DIR}/libQvPlugin-SS.so"
}
