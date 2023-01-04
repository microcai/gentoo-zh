# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIM_PLUGIN_VIM_VERSION="7.3"
inherit vim-plugin

DESCRIPTION="vim plugin: use clang for completing C/C++ code."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3526"
SRC_URI="https://github.com/xavierd/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
|| ( app-editors/vim[python] app-editors/gvim[python] )
>=dev-lang/python-2.3
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
