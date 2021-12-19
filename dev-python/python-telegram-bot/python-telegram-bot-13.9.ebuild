# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Python wrapper of telegram bots API"
HOMEPAGE="https://github.com/python-telegram-bot/python-telegram-bot"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/python-telegram-bot/python-telegram-bot"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

# This error is really strange
# UserWarning: python-telegram-bot is using upstream urllib3. This is allowed but not supported by python-telegram-bot maintainers.
RESTRICT="test mirror"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
"

DEPEND="test? (
	dev-python/APScheduler[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/flaky[${PYTHON_USEDEP}]
	dev-python/pytest-timeout[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/yapf[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme

python_prepare_all() {
	# do not make a test flaky report
	sed -i -e '/addopts/d' setup.cfg || die

	sed -i 's/from telegram.vendor.ptb_urllib3 //g' tests/test_*.py
	sed -i 's/telegram.vendor.ptb_urllib3.urllib3/urllib3/g' tests/test_*.py

	# Remove tests files that require network access
	rm tests/test_{animation,audio,bot,commandhandler,constants,conversationhandler}.py || die
	rm tests/test_{dispatcher,document,forcereply,inlinekeyboardmarkup,inputmedia}.py || die
	rm tests/test_{invoice,jobqueue,official,parsemode,persistence,photo,sticker,updater}.py || die
	rm tests/test_replykeyboard{markup,remove}.py || die
	rm tests/test_{video,videonote,voice}.py || die

	distutils-r1_python_prepare_all
}
