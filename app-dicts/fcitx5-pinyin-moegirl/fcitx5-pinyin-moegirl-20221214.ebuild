# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="moegirl.dict"
MY_PV="20220714"

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.moegirl.org.cn"
HOMEPAGE="https://github.com/outloudvi/mw2fcitx"
SRC_URI="https://github.com/outloudvi/mw2fcitx/releases/download/${MY_PV}/${MY_PN}"

LICENSE="Unlicense"
SLOT="5"
KEYWORDS="~amd64 ~x86"

DEPEND="app-i18n/fcitx:5"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${DISTDIR}"

src_install(){
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto ${DICT_PATH}
	doins ${MY_PN}
	fperms 0644 "${DICT_PATH}/${MY_PN}"
}
