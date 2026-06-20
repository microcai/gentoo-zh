# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_PN="${PN%-bin}"

DESCRIPTION="A full-featured download manager"
HOMEPAGE="https://motrix-next.pages.dev https://github.com/AnInsomniacy/motrix-next"
SRC_URI="
	amd64? (
		https://github.com/AnInsomniacy/motrix-next/releases/download/v${PV}/MotrixNext_${PV}_amd64.deb
			-> ${P}_amd64.deb
	)
	arm64? (
		https://github.com/AnInsomniacy/motrix-next/releases/download/v${PV}/MotrixNext_${PV}_arm64.deb
			-> ${P}_arm64.deb
	)
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/openssl:0/3
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"

RESTRICT="strip"
QA_PREBUILT="
	usr/bin/${MY_PN}
	usr/bin/${MY_PN}-engine
"

src_install() {
	dobin usr/bin/${MY_PN} usr/bin/${MY_PN}-engine

	insinto /usr/lib/MotrixNext
	doins -r usr/lib/MotrixNext/.

	domenu usr/share/applications/MotrixNext.desktop

	for size in 32 128; do
		doicon -s ${size} usr/share/icons/hicolor/${size}x${size}/apps/${MY_PN}.png
	done
	doicon -s 256 usr/share/icons/hicolor/256x256@2/apps/${MY_PN}.png
}
