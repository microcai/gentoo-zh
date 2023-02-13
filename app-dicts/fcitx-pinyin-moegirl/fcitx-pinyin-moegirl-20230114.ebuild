# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RESTRICT="mirror"

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.moegirl.org.cn"
HOMEPAGE="https://github.com/outloudvi/mw2fcitx"
SRC_URI="https://github.com/outloudvi/mw2fcitx/releases/download/${PV}/moegirl.dict -> ${P}.dict"

LICENSE="Unlicense"
SLOT="5"
KEYWORDS="amd64 arm mips x86"

DEPEND=""
BDEPEND=""
RDEPEND="app-i18n/fcitx:5"

S="${DISTDIR}"

src_install(){
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto ${DICT_PATH}
	doins ${P}.dict
	fperms 0644 "${DICT_PATH}/${P}.dict"
}
