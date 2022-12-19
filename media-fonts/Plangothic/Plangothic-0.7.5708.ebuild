# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font unpacker

DESCRIPTION="遍黑体项目（Plangothic Project）"
HOMEPAGE="https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic"
SRC_URI="
	https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic/archive/refs/tags/V${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="Plangothic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="
	+allideo
	fallback
"

RESTRICT="mirror"

FONT_SUFFIX="ttf"

src_install() {
	use allideo || rm "PlangothicP1-Regular (allideo).ttf" || die
	use fallback || rm "PlangothicP1-Regular (fallback).ttf" || die
	font_src_install
}
