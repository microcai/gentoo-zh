# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN=AppFlowy

DESCRIPTION="AppFlowy is an open-source alternative to Notion"
HOMEPAGE="https://www.appflowy.io/"
SRC_URI="
	https://github.com/AppFlowy-IO/AppFlowy/releases/download/${PV}/${MY_PN}-linux-x86.tar.gz -> ${P}.tar.gz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/openssl
	media-libs/harfbuzz
	media-libs/libepoxy
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
RDEPEND="${DEPEND}"

RESTRICT=" strip "

QA_PRESTRIPPED="
	/opt/${PN}/lib/libapp.so
	/opt/${PN}/lib/libflutter_linux_gtk.so
"
QA_PREBUILT="*"

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto "/opt/${PN}"
	doins -r data/ lib/ app_flowy

	fperms +x /opt/${PN}/lib -R
	fperms +x /opt/${PN}/app_flowy

	sed -i "s#\[CHANGE_THIS\]/AppFlowy#/opt/${PN}#g" appflowy.desktop.temp || die
	sed -i "s#/opt/${PN}/flowy_logo.svg#flowy_logo#g" appflowy.desktop.temp || die
	mv appflowy.desktop{.temp,} || die
	domenu appflowy.desktop
	doicon -s scalable flowy_logo.svg
}
