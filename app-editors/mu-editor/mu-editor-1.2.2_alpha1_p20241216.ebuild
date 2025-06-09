# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} pypy3 )

inherit distutils-r1 xdg desktop

DESCRIPTION="A simple Python editor for beginner programmers"
HOMEPAGE="
	https://github.com/mu-editor/mu
	https://pypi.org/project/mu-editor
"
GIT_COMMIT="563cb860c83b9453fc901d80dfb9ef8ed49503fc"
SRC_URI="https://github.com/mu-editor/mu/archive/${GIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/mu-${GIT_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${P}-gentoo.diff"
	"${FILESDIR}/${P}-serial-port-improvements.patch"
)

RDEPEND="
	>=dev-python/pyqt6-6.3.1[gui,widgets,serialport,svg,${PYTHON_USEDEP}]
	>=dev-python/qscintilla-2.13.3[${PYTHON_USEDEP}]
	>=dev-python/pyqt6-charts-6.3.1[${PYTHON_USEDEP}]
	dev-python/jupyter-client[${PYTHON_USEDEP}]
	>=dev-python/ipykernel-5.5.6[${PYTHON_USEDEP}]
	>=dev-python/qtconsole-5.4[${PYTHON_USEDEP}]
	>=dev-python/adafruit-board-toolkit-1.1[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	>=dev-python/nudatus-0.0.3[${PYTHON_USEDEP}]
	>=dev-python/flake8-3.8.3[${PYTHON_USEDEP}]
	>=dev-python/black-19.10_beta0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/semver-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/virtualenv-20.0.0[${PYTHON_USEDEP}]
	>=dev-python/pip-19.3[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

QA_DESKTOP_FILE="usr/share/applications/mu.codewith.editor.desktop"

python_install_all() {
	domenu "conf/mu.codewith.editor.desktop"
	doicon -s 256 "conf/mu.codewith.editor.png"
	distutils-r1_python_install_all
}

distutils_enable_sphinx docs
