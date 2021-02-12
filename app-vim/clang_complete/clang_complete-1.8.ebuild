# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

VIM_PLUGIN_VIM_VERSION="7.3"
inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: use clang for completing C/C++ code."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3526"
SRC_URI="https://github.com/Rip-Rip/${PN}/tarball/v${PV} -> ${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
|| ( app-editors/vim[python] app-editors/gvim[python] )
>=dev-lang/python-2.3
sys-devel/clang"

VIM_PLUGIN_HELPFILES="${PN}"

src_prepare() {
	rm Makefile
}

src_install() {
	dodoc README
	rm .gitignore README
	vim-plugin_src_install
}
