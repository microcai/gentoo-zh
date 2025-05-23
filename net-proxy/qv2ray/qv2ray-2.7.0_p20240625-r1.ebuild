# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg flag-o-matic

DESCRIPTION="Qt GUI fontend of v2ray"
HOMEPAGE="https://github.com/Qv2ray/Qv2ray"

GIT_COMMIT="d5c5aeb366e2fbe9c9243648af36b0d11da14920"
GIT_COMMIT_QJSONSTRUCT="02416895f2f1fb826f8e9207d8bbe5804b6d0441"
GIT_COMMIT_PURESOURCE="a4872c1fb429ed70eb183c3846bcf791bda75459"
GIT_COMMIT_QT_QRCODE="2d57d9c6e2341689d10f9360a16a08831a4a820b"
GIT_COMMIT_UVW="c56c05e6daaf6d7644b46d0d0bf902f099d0a218"
GIT_COMMIT_QVPLUGIN_INTERFACE="911c4adbb7b598435162da245ab248d215d3f018"
QRENCODE_PV="4.0.0"
SRC_URI="
	https://github.com/Qv2ray/Qv2ray/archive/${GIT_COMMIT}.tar.gz
		-> ${P}.tar.gz
	https://github.com/Qv2ray/QJsonStruct/archive/${GIT_COMMIT_QJSONSTRUCT}.tar.gz
		-> QJsonStruct-${GIT_COMMIT_QJSONSTRUCT}.tar.gz
	https://github.com/Qv2ray/PureSource/archive/${GIT_COMMIT_PURESOURCE}.tar.gz
		-> PureSource-${GIT_COMMIT_PURESOURCE}.tar.gz
	https://github.com/danielsanfr/qt-qrcode/archive/${GIT_COMMIT_QT_QRCODE}.tar.gz
		-> qt-qrcode-${GIT_COMMIT_QT_QRCODE}.tar.gz
	https://github.com/fukuchi/libqrencode/archive/refs/tags/v${QRENCODE_PV}.tar.gz
		-> qrencode-${QRENCODE_PV}.tar.gz
	https://github.com/skypjack/uvw/archive/${GIT_COMMIT_UVW}.tar.gz
		-> uvw-${GIT_COMMIT_UVW}.tar.gz
	https://github.com/Qv2ray/QvPlugin-Interface/archive/${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
		-> QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
	https://github.com/Qv2ray/Qv2ray/commit/d0d6f7c891f69c19086ff3a8b614462de6524af0.patch
		-> ${P}-custom-core-version.patch
"

S="${WORKDIR}/Qv2ray-${GIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test +themes"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qtsvg:6
	dev-libs/libuv:=
	net-libs/grpc:=
	dev-libs/protobuf:=
	net-misc/curl
	dev-libs/qnodeeditor
"
RDEPEND="
	|| (
		net-proxy/v2ray
		net-proxy/v2ray-bin
		net-proxy/Xray
	)
	dev-libs/openssl:0=
	${DEPEND}
"
DEPEND+=">=dev-libs/singleapplication-3.5.2_p20250124"
BDEPEND="dev-qt/qttools:6[linguist]"

PATCHES=(
	"${FILESDIR}/${P}-fix-building-with-freestanding-singleapplication.patch"
	"${DISTDIR}/${P}-custom-core-version.patch"
)

src_unpack() {
	default
	cd "${S}/3rdparty" || die
	rmdir QJsonStruct puresource qt-qrcode uvw || die
	mv "${WORKDIR}/QJsonStruct-${GIT_COMMIT_QJSONSTRUCT}" QJsonStruct || die
	mv "${WORKDIR}/PureSource-${GIT_COMMIT_PURESOURCE}" puresource || die
	mv "${WORKDIR}/qt-qrcode-${GIT_COMMIT_QT_QRCODE}" qt-qrcode || die
	rmdir qt-qrcode/lib/libqrencode || die
	mv "${WORKDIR}/libqrencode-${QRENCODE_PV}" qt-qrcode/lib/libqrencode || die
	mv "${WORKDIR}/uvw-${GIT_COMMIT_UVW}" uvw || die
	rmdir "${S}/src/plugin-interface" || die
	mv "${WORKDIR}/QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}" "${S}/src/plugin-interface" || die
}

src_prepare() {
	sed -i -e 's/__STATIC/STATIC_IN_RELEASE/' cmake/qrencode.cmake || die
	cmake_src_prepare
}

src_configure() {
	# https://github.com/Qv2ray/Qv2ray/issues/1734
	filter-lto

	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DQV2RAY_DISABLE_AUTO_UPDATE=ON
		-DQV2RAY_HAS_BUILTIN_THEMES=$(usex themes)
		-DQV2RAY_QT6=ON
		-DUSE_SYSTEM_LIBUV=ON
		-DQV2RAY_SINGLEAPPLICATION_PROVIDER=package
		-DQV2RAY_QNODEEDITOR_PROVIDER=package
	)
	cmake_src_configure
}
