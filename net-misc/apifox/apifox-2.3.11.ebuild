# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="API 文档、API 调试、API Mock、API 自动化测试"
HOMEPAGE="https://www.apifox.cn/"
SRC_URI="
	amd64? ( https://cdn.apifox.cn/download/Apifox-linux-latest.zip -> ${P}-amd64.zip )
"

LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="binchecks strip"

BDEPEND="
	app-arch/unzip
	sys-fs/fuse:0
"

S="${WORKDIR}"

src_install() {
	into /opt/apifox
	dobin "${S}/Apifox.AppImage"
	domenu "${FILESDIR}/apifox.desktop"
	doicon -s scalable "${FILESDIR}/apifox.svg"
}
