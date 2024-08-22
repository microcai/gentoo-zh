# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.moegirl.org.cn"
HOMEPAGE="https://github.com/outloudvi/mw2fcitx"
SRC_URI="https://github.com/outloudvi/mw2fcitx/releases/download/${PV}/moegirl.dict -> ${P}.dict"

S="${DISTDIR}"

LICENSE="Unlicense CC-BY-NC-SA-3.0"
SLOT="5"
KEYWORDS="~amd64 ~mips ~x86"

RDEPEND="
	app-i18n/fcitx:5
	!app-dicts/fcitx-pinyin-moegirl
"

src_install() {
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto "${DICT_PATH}"
	newins "${P}.dict" moegirl.dict
	fperms 0644 "${DICT_PATH}/moegirl.dict"
}
