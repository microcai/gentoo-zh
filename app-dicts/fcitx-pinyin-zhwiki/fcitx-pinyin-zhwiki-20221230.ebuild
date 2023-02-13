# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="zhwiki-${PV}.dict"
MY_PV="0.2.4"

RESTRICT="mirror"

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.wikipedia.org"
HOMEPAGE="https://github.com/felixonmars/fcitx5-pinyin-zhwiki"
SRC_URI="https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/${MY_PV}/${MY_PN} -> ${P}.dict"

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
