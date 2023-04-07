# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd xdg

DESCRIPTION="qBittorrent Enhanced, based on qBittorrent"
HOMEPAGE="https://github.com/c0re100/qBittorrent-Enhanced-Edition"

SRC_URI="https://github.com/c0re100/qBittorrent-Enhanced-Edition/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qBittorrent-Enhanced-Edition-release-${PV}"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="+dbus +gui webui"

RDEPEND="
		>=dev-libs/boost-1.65.0-r1:=
		dev-libs/openssl:=
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5[ssl]
		dev-qt/qtsql:5
		dev-qt/qtxml:5
		>=net-libs/libtorrent-rasterbar-1.2.14:=
		sys-libs/zlib
		dbus? ( dev-qt/qtdbus:5 )
		gui? (
				dev-libs/geoip
				dev-qt/qtgui:5
				dev-qt/qtsvg:5
				dev-qt/qtwidgets:5
		)
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5
		virtual/pkgconfig"

DOCS=( AUTHORS Changelog CONTRIBUTING.md README.md TODO )

src_configure() {
	local mycmakeargs=(
		-DDBUS=$(usex dbus)
		-DGUI=$(usex gui)
		-DWEBUI=$(usex webui)

		-DSYSTEMD=ON
		-DSYSTEMD_SERVICES_INSTALL_DIR=$(systemd_get_systemunitdir)

		-DVERBOSE_CONFIGURE=ON

		-DQT6=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
}
