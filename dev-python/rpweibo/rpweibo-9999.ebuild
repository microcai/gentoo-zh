# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1 git-2

DESCRIPTION="An API Wrapper for Sina Weibo"
HOMEPAGE="https://github.com/WeCase/rpweibo"
SRC_URI=""

EGIT_HAS_SUBMODULE=0
EGIT_REPO_URI="git://github.com/WeCase/rpweibo.git"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""

python_install_all() {
	distutils-r1_python_install_all
}
