# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker

DESCRIPTION="A Linux client for QQ and more."
HOMEPAGE="https://github.com/Icalingua/Icalingua"
SRC_URI="https://github.com/Icalingua/${PN}/releases/download/v${PV}/icalingua_${PV}_amd64.deb -> ${P}.deb"

LICENSE="GPL-3 AGPL-3 GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install(){
	insinto "/opt"
	doins -r "${WORKDIR}/opt/${PN}"
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/icalingua.png
	domenu usr/share/applications/icalingua.desktop
	fperms 0755 "/opt/${PN}/icalingua"
}
