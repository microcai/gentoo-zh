# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="一款命令行式哔哩哔哩下载器"
HOMEPAGE="https://github.com/nilaoda/BBDown"
SRC_URI="https://github.com/nilaoda/BBDown/releases/download/${PV}/BBDown_${PV}_20240814_linux-x64.zip -> ${P}-amd64.zip"

S="${WORKDIR}"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="binchecks strip"

BDEPEND="
	app-arch/unzip
"

src_install() {
	dobin "${S}/BBDown"
}
