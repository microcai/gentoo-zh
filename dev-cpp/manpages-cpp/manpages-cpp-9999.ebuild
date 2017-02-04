# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils git-2

DESCRIPTION="Generates C++ man pages from cplusplus.com"
HOMEPAGE="https://github.com/Aitjcize/cppman/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/aitjcize/cppman.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/sqlite3dbm
         sys-apps/groff"

PYTHON_MODNAME="cppman"

src_compile () {
	distutils_src_compile || die "compile failed"
}

src_install () {
	distutils_src_install || die "install failed"
}
