# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_4 python3_5)
PYTHON_REQ_USE="ssl,xml"

inherit distutils-r1 git-r3

DESCRIPTION="NetEase-MusicBox"
HOMEPAGE="https://github.com/darknessomi/musicbox"
EGIT_REPO_URI="git://github.com/darknessomi/musicbox.git"
EGIT_BRANCH="master"

# The developers of netease-musicbox don't even know how to
# use "git tag" to release a new version, we have to check
# everything in "git log" manually.

# They have learned how to use "git tag", congrats!
EGIT_COMMIT="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64  ~x86"

IUSE=""

RDEPEND="
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.4.1:4[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/future-0.15.2[${PYTHON_USEDEP}]
	media-sound/mpg123
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
