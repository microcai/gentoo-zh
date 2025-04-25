# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg flag-o-matic

DESCRIPTION="Qt GUI fontend of v2ray"
HOMEPAGE="https://github.com/Qv2ray/Qv2ray"

GIT_COMMIT="d5c5aeb366e2fbe9c9243648af36b0d11da14920"
GIT_COMMIT_QCODEEDITOR="ed1196a91dd6415c5ad6d0e85a90630e9b3b9f6c"
GIT_COMMIT_QNODEEDITOR="808a7cf0359771a474db17a82cbf631746d8735d"
GIT_COMMIT_QJSONSTRUCT="02416895f2f1fb826f8e9207d8bbe5804b6d0441"
GIT_COMMIT_PURESOURCE="a4872c1fb429ed70eb183c3846bcf791bda75459"
GIT_COMMIT_QT_QRCODE="2d57d9c6e2341689d10f9360a16a08831a4a820b"
GIT_COMMIT_UVW="c56c05e6daaf6d7644b46d0d0bf902f099d0a218"
GIT_COMMIT_QVPLUGIN_INTERFACE="911c4adbb7b598435162da245ab248d215d3f018"
SINGLEAPPLICATION_PV="3.5.2"
QRENCODE_PV="4.0.0"
SRC_URI="
	https://github.com/Qv2ray/Qv2ray/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/cpeditor/QCodeEditor/archive/${GIT_COMMIT_QCODEEDITOR}.tar.gz
		-> QCodeEditor-${GIT_COMMIT_QCODEEDITOR}.tar.gz
	https://github.com/Qv2ray/QJsonStruct/archive/${GIT_COMMIT_QJSONSTRUCT}.tar.gz
		-> QJsonStruct-${GIT_COMMIT_QJSONSTRUCT}.tar.gz
	https://github.com/Qv2ray/QNodeEditor/archive/${GIT_COMMIT_QNODEEDITOR}.tar.gz
		-> QNodeEditor-${GIT_COMMIT_QNODEEDITOR}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/refs/tags/v${SINGLEAPPLICATION_PV}.tar.gz
		-> SingleApplication-${SINGLEAPPLICATION_PV}.tar.gz
	https://github.com/Qv2ray/PureSource/archive/${GIT_COMMIT_PURESOURCE}.tar.gz
		-> PureSource-${GIT_COMMIT_PURESOURCE}.tar.gz
	https://github.com/danielsanfr/qt-qrcode/archive/${GIT_COMMIT_QT_QRCODE}.tar.gz
		-> qt-qrcode-${GIT_COMMIT_QT_QRCODE}.tar.gz
	https://fukuchi.org/works/qrencode/qrencode-${QRENCODE_PV}.tar.bz2
	https://github.com/skypjack/uvw/archive/${GIT_COMMIT_UVW}.tar.gz -> uvw-${GIT_COMMIT_UVW}.tar.gz
	https://github.com/Qv2ray/QvPlugin-Interface/archive/${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
		-> QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
"

S="${WORKDIR}/Qv2ray-${GIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test +themes xray"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qtsvg:6
	dev-libs/libuv:=
	net-libs/grpc:=
	dev-libs/protobuf:=
	net-misc/curl
"
# app-alternatives/v2ray-geo{ip,site}[loyalsoldier] cause V2ray v5 core to crash
# https://github.com/Qv2ray/Qv2ray/issues/1717
RDEPEND="
	!xray? (
			|| (
				=net-proxy/v2ray-bin-5*
				=net-proxy/v2ray-5*
			)
			!app-alternatives/v2ray-geoip[loyalsoldier]
			!app-alternatives/v2ray-geosite[loyalsoldier]
		)
	xray? ( net-proxy/Xray )
	dev-libs/openssl:0=
	${DEPEND}
"
BDEPEND="dev-qt/qttools:6[linguist]"

src_unpack() {
	default
	cd "${S}/3rdparty" || die
	rmdir QCodeEditor QJsonStruct QNodeEditor SingleApplication puresource qt-qrcode uvw || die
	mv "${WORKDIR}/QCodeEditor-${GIT_COMMIT_QCODEEDITOR}" QCodeEditor || die
	mv "${WORKDIR}/QJsonStruct-${GIT_COMMIT_QJSONSTRUCT}" QJsonStruct || die
	mv "${WORKDIR}/QNodeEditor-${GIT_COMMIT_QNODEEDITOR}" QNodeEditor || die
	mv "${WORKDIR}/SingleApplication-${SINGLEAPPLICATION_PV}" SingleApplication || die
	mv "${WORKDIR}/PureSource-${GIT_COMMIT_PURESOURCE}" puresource || die
	mv "${WORKDIR}/qt-qrcode-${GIT_COMMIT_QT_QRCODE}" qt-qrcode || die
	rmdir qt-qrcode/lib/libqrencode || die
	mv "${WORKDIR}/qrencode-${QRENCODE_PV}" qt-qrcode/lib/libqrencode || die
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
		-DQV2RAY_USE_V5_CORE=$(usex !xray)
		-DUSE_SYSTEM_LIBUV=ON
	)
	cmake_src_configure
}
