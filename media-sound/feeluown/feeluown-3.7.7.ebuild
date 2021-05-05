# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

inherit distutils-r1 desktop

DESCRIPTION="A user-friendly and hackable music player"
HOMEPAGE="https://github.com/feeluown/FeelUOwn"
MY_P="${P/_alpha/a}"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+netease +local +qqmusic +kuwo +webengine"

RDEPEND="
	dev-python/janus[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/qasync[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.8.1[${PYTHON_USEDEP}]
"

PDEPEND="
	media-video/mpv[libmpv]
	netease? ( dev-python/fuo-netease[${PYTHON_USEDEP}] )
	local? ( dev-python/fuo-local[${PYTHON_USEDEP}] )
	qqmusic? ( dev-python/fuo-qqmusic[${PYTHON_USEDEP}] )
	kuwo? ( dev-python/fuo-kuwo[$PYTHON_USEDEP] )
	webengine? ( dev-python/PyQtWebEngine[$PYTHON_USEDEP] )
"

DEPEND="
	${RDEPEND}
	${PDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all

	domenu "${FILESDIR}/${PN}.desktop"
	newicon "${S}/feeluown/icons/feeluown.png" "${PN}.png"
}
