# Copyright 2024 Gentoo Authors
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
GIT_COMMIT=d8a382453f312046d16e25c6e247085bb02c8fb3
DICTV="20240809"
SRC_URI="
	https://github.com/outloudvi/mw2fcitx/archive/${GIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz
	test? ( https://github.com/outloudvi/mw2fcitx/releases/download/${DICTV}/titles.txt -> titles-${PV}.${DICTV}.txt )
"

S="${WORKDIR}/mw2fcitx-${GIT_COMMIT}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-i18n/opencc-1.1.7[python,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/pypinyin-0.52.0[${PYTHON_USEDEP}]')
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	sed -i -e '/--cov/d' pytest.ini || die

	# remove network access in test
	sed -i -e '6c \    pipeline = MWFPipeline()' tests/lib/test_zhwiki.py || die
	sed -i -e "7c \    pipeline.load_titles_from_file('${DISTDIR}/titles-${PV}.${DICTV}.txt')" \
		tests/lib/test_zhwiki.py || die
}
