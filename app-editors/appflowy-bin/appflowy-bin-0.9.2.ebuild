# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN="AppFlowy"

DESCRIPTION="AppFlowy is an open-source alternative to Notion"
HOMEPAGE="https://www.appflowy.io/"
SRC_URI="
	https://github.com/AppFlowy-IO/AppFlowy/releases/download/${PV}/AppFlowy-${PV}-linux-x86_64.tar.gz
"
S="${WORKDIR}/${MY_PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	dev-libs/openssl:0/3
	dev-libs/keybinder:3
	media-video/mpv:0[libmpv]
	media-libs/harfbuzz
	media-libs/libepoxy
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/pango
	x11-misc/xdg-user-dirs[gtk]
"
RDEPEND="${DEPEND}"

QA_PRESTRIPPED="
	/opt/${PN}/lib/libapp.so
	/opt/${PN}/lib/libflutter_linux_gtk.so
"
QA_PREBUILT="*"

src_install() {
	dosym -r /usr/lib64/libmpv.so.2 /usr/lib64/libmpv.so.1

	insinto "/opt/${PN}"
	doins -r data/ lib/ AppFlowy

	fperms +x /opt/${PN}/AppFlowy

	domenu "${FILESDIR}/AppFlowy.desktop"
	doicon -s scalable data/flutter_assets/assets/images/flowy_logo.svg
}
