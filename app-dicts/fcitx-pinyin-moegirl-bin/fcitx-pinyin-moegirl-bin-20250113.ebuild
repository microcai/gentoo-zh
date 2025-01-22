# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.moegirl.org.cn"
HOMEPAGE="https://github.com/outloudvi/mw2fcitx"
SRC_URI="
	fcitx? ( https://github.com/outloudvi/mw2fcitx/releases/download/${PV}/moegirl.dict -> ${P}.dict )
	rime? ( https://github.com/outloudvi/mw2fcitx/releases/download/${PV}/moegirl.dict.yaml -> ${P}.dict.yaml )
"

S="${DISTDIR}"

LICENSE="Unlicense CC-BY-NC-SA-3.0"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+fcitx rime"
REQUIRED_USE="|| ( fcitx rime )"

RDEPEND="
	fcitx? ( app-i18n/fcitx:5 )
	rime? ( || ( app-i18n/ibus-rime app-i18n/fcitx-rime ) )
	!app-dicts/fcitx-pinyin-moegirl
"

src_install() {
	if use fcitx; then
		DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
		insinto "${DICT_PATH}"
		newins "${P}.dict" moegirl.dict
		fperms 0644 "${DICT_PATH}/moegirl.dict"
	fi

	if use rime; then
		DICT_PATH="/usr/share/rime-data"
		insinto "${DICT_PATH}"
		newins "${P}.dict.yaml" moegirl.dict.yaml
		fperms 0644 "${DICT_PATH}/moegirl.dict.yaml"
	fi
}
