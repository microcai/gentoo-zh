# Copyright 1999-2025 Gentoo Authors
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
IUSE="+fcitx rime"
REQUIRED_USE="|| ( fcitx rime )"

RDEPEND="
	fcitx? ( app-i18n/fcitx:5 )
	rime? ( || ( app-i18n/ibus-rime app-i18n/fcitx-rime ) )
"
BDEPEND="
	${PYTHON_DEPS}
	fcitx? ( app-i18n/libime:5 )
	$(python_gen_any_dep '
		dev-python/mw2fcitx[${PYTHON_SINGLE_USEDEP}]
	')
"

python_check_deps() {
	python_has_version "dev-python/mw2fcitx[${PYTHON_SINGLE_USEDEP}]"
}

src_prepare() {
	# remove unneeded outputs
	sed -i -e '10d' utils/moegirl_dict.py || die
	use !fcitx && (sed -i -e '26,30d' utils/moegirl_dict.py || die)
	use !rime && (sed -i -e '21,26d' utils/moegirl_dict.py || die)
	default
}

src_compile() {
	mw2fcitx -c utils/moegirl_dict.py || die
}

src_install() {
	if use fcitx; then
		DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
		insinto "${DICT_PATH}"
		doins moegirl.dict
		fperms 0644 "${DICT_PATH}/moegirl.dict"
	fi

	if use rime; then
		DICT_PATH="/usr/share/rime-data"
		insinto "${DICT_PATH}"
		doins moegirl.dict.yaml
		fperms 0644 "${DICT_PATH}/moegirl.dict.yaml"
	fi
}
