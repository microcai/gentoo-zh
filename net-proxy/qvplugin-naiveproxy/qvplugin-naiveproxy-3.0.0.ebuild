# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plugin for Qv2ray to support NaiveProxy in Qv2ray"
HOMEPAGE="https://github.com/Qv2ray/QvPlugin-NaiveProxy"
GIT_COMMIT_QVPLUGIN_INTERFACE="911c4adbb7b598435162da245ab248d215d3f018"
SRC_URI="
	https://github.com/Qv2ray/QvPlugin-NaiveProxy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Qv2ray/QvPlugin-Interface/archive/${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
		-> QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}.tar.gz
"

S="${WORKDIR}/QvPlugin-NaiveProxy-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6[gui,network,widgets]"
RDEPEND="
	>=net-proxy/qv2ray-2.7.0
	|| ( net-proxy/naiveproxy-bin net-proxy/naiveproxy )
	${DEPEND}
"

src_unpack() {
	default
	rmdir "${S}/interface" || die
	mv "${WORKDIR}/QvPlugin-Interface-${GIT_COMMIT_QVPLUGIN_INTERFACE}" "${S}/interface" || die
}

src_configure() {
	local mycmakeargs=(
		-DQVPLUGIN_USE_QT6=ON
	)
	cmake_src_configure
}

src_install(){
	insinto "/usr/share/qv2ray/plugins"
	insopts -m755
	doins "${BUILD_DIR}/libQvPlugin-NaiveProxy.so"
}
