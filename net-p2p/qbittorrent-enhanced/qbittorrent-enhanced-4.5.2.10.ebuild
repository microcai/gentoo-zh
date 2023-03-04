# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_IN_SOURCE_BUILD=ON

inherit cmake systemd xdg

DESCRIPTION="qBittorrent Enhanced, based on qBittorrent"
HOMEPAGE="https://github.com/c0re100/qBittorrent-Enhanced-Edition"

RESTRICT="mirror"
SRC_URI="https://github.com/c0re100/qBittorrent-Enhanced-Edition/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qBittorrent-Enhanced-Edition-release-${PV}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+dbus webui qt6 +qt5"

REQUIRED_USE="?? ( qt5 qt6 )"

RDEPEND="
		>=dev-libs/boost-1.65.0-r1:=
		dev-libs/openssl:=
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5[ssl]
		dev-qt/qtsql:5
		dev-qt/qtxml:5
		net-libs/libtorrent-rasterbar
		sys-libs/zlib
		dbus? (
			qt5? ( dev-qt/qtdbus:5 )
			qt6? ( dev-qt/qtbase:6 )
		)
		qt5? (
				dev-libs/geoip
				dev-qt/qtgui:5
				dev-qt/qtsvg:5
				dev-qt/qtwidgets:5
		)
		qt6? (
				dev-libs/geoip
				dev-qt/qtbase:6
				dev-qt/qtsvg:6
		)
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5
		virtual/pkgconfig"

DOCS=( AUTHORS Changelog CONTRIBUTING.md README.md)

PATCHES=(
	${FILESDIR}/4.5-fix-compile-error-when-disable-webui.patch
)

src_configure() {
	set enable_gui="OFF"
	if use qt5 || use qt6 ; then
		enable_gui="ON"
	fi

	local mycmakeargs=(
		-DDBUS=$(usex dbus)
		-DGUI=${enable_gui}
		-DWEBUI=$(usex webui)

		-DSYSTEMD=ON
		-DSYSTEMD_SERVICES_INSTALL_DIR=$(systemd_get_systemunitdir)

		-DVERBOSE_CONFIGURE=ON

		-DQT6=$(usex qt6)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
}
