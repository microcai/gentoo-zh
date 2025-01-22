# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Build fcitx5 libraries from MediaWiki sites"
HOMEPAGE="
	https://github.com/outloudvi/mw2fcitx
	https://pypi.org/project/mw2fcitx
"
DICTV="20250113"
SRC_URI+="
	test? ( https://github.com/outloudvi/mw2fcitx/releases/download/${DICTV}/titles.txt -> titles-${DICTV}.txt )
"

LICENSE="Unlicense test? ( CC-BY-NC-SA-3.0 )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-i18n/opencc-1.1.7[python(-),${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/pypinyin-0.52.0[${PYTHON_USEDEP}]
		>=dev-python/urllib3-2.2.2[${PYTHON_USEDEP}]
	')
"

PATCHES=( "${FILESDIR}/${P}-test-no-network.patch" )

distutils_enable_tests pytest

src_unpack() {
	default
	use test && (cp "${DISTDIR}/titles-${DICTV}.txt" "${S}/titles.txt" || die)
}
