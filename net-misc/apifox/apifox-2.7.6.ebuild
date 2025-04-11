# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="API 文档、API 调试、API Mock、API 自动化测试"
HOMEPAGE="https://www.apifox.cn/"
SRC_URI="
	amd64? ( https://file-assets.apifox.com/download/Apifox-linux-latest.zip -> ${P}-amd64.zip )
"

S="${WORKDIR}"
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror"

BDEPEND="
	app-arch/unzip
	sys-fs/fuse:0
"

src_install() {
	into /opt/apifox
	dobin "${S}/Apifox.AppImage"
	domenu "${FILESDIR}/apifox.desktop"
	doicon -s scalable "${FILESDIR}/apifox.svg"
}
