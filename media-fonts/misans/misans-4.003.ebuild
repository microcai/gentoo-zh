# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN="MiSans"

DESCRIPTION="MiSans 是由小米主导,联合汉仪发布的可免费使用的字体"
HOMEPAGE="https://hyperos.mi.com/font"
SRC_URI="https://hyperos.mi.com/font-download/${MY_PN}.zip"
S="${WORKDIR}/${MY_PN}"

LICENSE="MiSans"
SLOT="0"
KEYWORDS="~amd64"
BDEPEND="app-arch/unzip"
FONT_SUFFIX="ttf otf"

RESTRICT="mirror"

src_install() {
	cp otf/*.otf . || die
	cp ttf/*.ttf . || die
	font_src_install
}
