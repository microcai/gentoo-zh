# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit python-any-r1

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.moegirl.org.cn"
HOMEPAGE="https://github.com/outloudvi/mw2fcitx"
SRC_URI="https://github.com/outloudvi/mw2fcitx/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/mw2fcitx-${PV}"

LICENSE="Unlicense CC-BY-NC-SA-3.0"
SLOT="5"
KEYWORDS="~amd64"

RDEPEND="
	app-i18n/fcitx:5
	!app-dicts/fcitx-pinyin-moegirl-bin
"
BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-python/mw2fcitx[${PYTHON_SINGLE_USEDEP}]
	')
"

python_check_deps() {
	python_has_version "dev-python/mw2fcitx[${PYTHON_SINGLE_USEDEP}]"
}

src_prepare() {
	# remove unneeded outputs
	sed -i -e '10d;20,24d' utils/moegirl_dict.py
	default
}

src_compile() {
	mw2fcitx -c utils/moegirl_dict.py
}

src_install() {
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto "${DICT_PATH}"
	doins moegirl.dict
	fperms 0644 "${DICT_PATH}/moegirl.dict"
}
