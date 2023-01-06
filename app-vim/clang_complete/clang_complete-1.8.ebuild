# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

VIM_PLUGIN_VIM_VERSION="7.3"
inherit vim-plugin python-single-r1

DESCRIPTION="vim plugin: use clang for completing C/C++ code."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3526"
SRC_URI="https://github.com/xavierd/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
		${PYTHON_DEPS}
		|| (
				app-editors/vim[python,${PYTHON_SINGLE_USEDEP}]
				app-editors/gvim[python,${PYTHON_SINGLE_USEDEP}]
		)
sys-devel/clang"

VIM_PLUGIN_HELPFILES="${PN}"

src_prepare() {
	default

	rm Makefile || die
}

src_install() {
	dodoc README
	rm .gitignore README || die
	vim-plugin_src_install
}
