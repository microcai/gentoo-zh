# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CONVERTERV=$(ver_cut 1-3)
WEBSLANGV=$(ver_cut 4)

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.wikipedia.org"
HOMEPAGE="https://github.com/felixonmars/fcitx5-pinyin-zhwiki"
SRC_URI="https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/${CONVERTERV}/zhwiki-${WEBSLANGV}.dict -> ${P}.dict"

S="${DISTDIR}"

LICENSE="
	Unlicense
	|| ( CC-BY-SA-4.0 FDL-1.3 )
"
SLOT="5"
KEYWORDS="~amd64 ~mips ~x86"

RDEPEND="app-i18n/fcitx:5"

src_install() {
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto "${DICT_PATH}"
	newins "${P}.dict" zhwiki.dict
	fperms 0644 "${DICT_PATH}/zhwiki.dict"
}
