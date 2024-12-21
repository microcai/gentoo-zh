# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-pinyin-zhwiki"
CONVERTERV=$(ver_cut 1-3)
WEBSLANGV=$(ver_cut 4)

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.wikipedia.org"
HOMEPAGE="https://github.com/felixonmars/fcitx5-pinyin-zhwiki"
SRC_URI="
	fcitx? ( https://github.com/felixonmars/${MY_PN}/releases/download/${CONVERTERV}/zhwiki-${WEBSLANGV}.dict
		-> ${P}.dict )
	rime? ( https://github.com/felixonmars/${MY_PN}/releases/download/${CONVERTERV}/zhwiki-${WEBSLANGV}.dict.yaml
		-> ${P}.dict.yaml )
"

S="${DISTDIR}"

LICENSE="Unlicense || ( CC-BY-SA-4.0 FDL-1.3 )"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+fcitx rime"
REQUIRED_USE="|| ( fcitx rime )"

RDEPEND="
	fcitx? ( app-i18n/fcitx:5 )
	rime? ( || ( app-i18n/ibus-rime app-i18n/fcitx-rime ) )
	!app-dicts/fcitx-pinyin-zhwiki
"

src_install() {
	if use fcitx; then
		DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
		insinto "${DICT_PATH}"
		newins "${P}.dict" zhwiki.dict
		fperms 0644 "${DICT_PATH}/zhwiki.dict"
	fi

	if use rime; then
		DICT_PATH="/usr/share/rime-data"
		insinto "${DICT_PATH}"
		newins "${P}.dict.yaml" zhwiki.dict.yaml
		fperms 0644 "${DICT_PATH}/zhwiki.dict.yaml"
	fi
}
