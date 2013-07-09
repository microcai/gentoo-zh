# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator

MY_VER="$(get_version_component_range 1-3)+git$(get_version_component_range 4)~16f12ba5e4"

DESCRIPTION="Clock plugins for Deepin Desktop Environment"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/deepin-desktop-environment-plugins/deepin-desktop-environment-plugins_${MY_VER}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dde-base/deepin-artwork
		dde-base/deepin-desktop-environment"
RDEPEND="${DEPEND}"

S="${WORKDIR}/deepin-desktop-environment-plugins-${MY_VER}/audio_helper"

src_install() {
		insinto "/usr/share/dde/resources/desktop/plugin/audio_helper"
		doins audio_helper.css audio_helper.js circle.png circle_press.png info.ini light.png running.png static.png
}