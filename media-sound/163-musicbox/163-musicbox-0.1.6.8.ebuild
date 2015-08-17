# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils git-r3

DESCRIPTION="NetEase-MusicBox"
HOMEPAGE="https://github.com/darknessomi/musicbox"
EGIT_REPO_URI="git://github.com/darknessomi/musicbox.git"
EGIT_BRANCH="master"

LICENSE="MIT License "
SLOT="0"
KEYWORDS="~amd64  ~x86"

IUSE=""

RDEPEND="
	dev-python/requests
	dev-python/beautifulsoup:4
	dev-python/pycrypto
"

DEPEND="${RDEPEND}"

src_compile() {
	distutils_src_compile
}

src_install () {
	distutils_src_install
}
