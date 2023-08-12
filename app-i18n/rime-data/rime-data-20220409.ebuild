# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="brise"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Data resources for Rime Input Method Engine"
HOMEPAGE="https://rime.im/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="
	bopomofo
	cangjie
	+double-pinyin
	+essay
	+luna-pinyin
	+octagram
	pinyin-simp
	+prelude
	+stroke
	+terra-pinyin
	+wubi
"

DEPEND="
	app-i18n/librime
	bopomofo? ( app-i18n/rime-bopomofo )
	cangjie? ( app-i18n/rime-cangjie )
	double-pinyin? ( app-i18n/rime-double-pinyin )
	essay? ( app-i18n/rime-essay )
	luna-pinyin? ( app-i18n/rime-luna-pinyin )
	octagram? ( app-i18n/rime-octagram-data )
	pinyin-simp? ( app-i18n/rime-pinyin-simp )
	prelude? ( app-i18n/rime-prelude )
	stroke? ( app-i18n/rime-stroke )
	terra-pinyin? ( app-i18n/rime-terra-pinyin )
	wubi? ( app-i18n/rime-wubi )
"
RDEPEND="${DEPEND}"
