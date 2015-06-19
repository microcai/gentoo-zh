# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{3_2,3_3} )

inherit distutils-r1 git-2

DESCRIPTION="A SDK for Sina Weibo, WeCase's fork."
HOMEPAGE="https://github.com/WeCase/sinaweibopy"
SRC_URI=""

EGIT_HAS_SUBMODULE=0
EGIT_REPO_URI="git://github.com/WeCase/sinaweibopy.git"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""

python_install_all() {
	distutils-r1_python_install_all
}
