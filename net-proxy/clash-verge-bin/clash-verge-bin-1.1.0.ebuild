# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"
DEB_VER="1.1.0"

inherit unpacker desktop xdg

DESCRIPTION="A Clash GUI based on tauri"
HOMEPAGE="https://github.com/zzzgydi/clash-verge"

KEYWORDS="~amd64"

SRC_URI="https://github.com/zzzgydi/${MY_PN}/releases/download/v${DEB_VER}/${MY_PN}_${DEB_VER}_amd64.deb"

LICENSE="GPL-3"
SLOT="0"
IUSE="system-clash"

DEPEND=""
RDEPEND="
	dev-libs/libappindicator
	net-libs/webkit-gtk
	dev-libs/gobject-introspection-common
	system-clash? ( net-proxy/clash )
	!system-clash? ( !net-proxy/clash )
"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	if	use	system-clash;	then
		dobin usr/bin/{clash-meta,clash-verge}
	else
		dobin usr/bin/{clash,clash-meta,clash-verge}
	fi

	insinto /usr/lib/${MY_PN}/resources
	doins usr/lib/${MY_PN}/resources/Country.mmdb

	domenu usr/share/applications/${MY_PN}.desktop

	doicon -s 128 usr/share/icons/hicolor/128x128/apps/${MY_PN}.png
	doicon -s 256 usr/share/icons/hicolor/256x256@2/apps/${MY_PN}.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/${MY_PN}.png
}
