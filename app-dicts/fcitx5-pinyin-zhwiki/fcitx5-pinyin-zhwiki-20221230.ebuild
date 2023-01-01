# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="zhwiki-${PV}.dict"
MY_PV="0.2.4"

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.wikipedia.org"
HOMEPAGE="https://github.com/felixonmars/fcitx5-pinyin-zhwiki"
SRC_URI="https://github.com/felixonmars/${PN}/releases/download/${MY_PV}/${MY_PN}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${DISTDIR}"

src_install(){
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto ${DICT_PATH}
	doins ${MY_PN}
	fperms 0644 "${DICT_PATH}/${MY_PN}"
}
