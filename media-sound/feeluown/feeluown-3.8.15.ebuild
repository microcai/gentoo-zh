# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 desktop

DESCRIPTION="A user-friendly and hackable music player"
HOMEPAGE="https://github.com/feeluown/FeelUOwn"
MY_P="${P/_alpha/a}"
S="${WORKDIR}/FeelUOwn-${PV}"
SRC_URI="https://github.com/${PN}/FeelUOwn/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+netease +qqmusic +kuwo +webengine +ytmusic +bilibili"

RDEPEND="
	dev-python/janus[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/PyQt5[gui,widgets,opengl,svg,${PYTHON_USEDEP}]
	dev-python/qasync[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.8.1[${PYTHON_USEDEP}]
"

PDEPEND="
	media-video/mpv[libmpv]
	netease? ( dev-python/fuo-netease[${PYTHON_USEDEP}] )
	qqmusic? ( dev-python/fuo-qqmusic[${PYTHON_USEDEP}] )
	kuwo? ( dev-python/fuo-kuwo[$PYTHON_USEDEP] )
	bilibili? ( dev-python/feeluown-bilibili[$PYTHON_USEDEP] )
	ytmusic? ( dev-python/fuo-ytmusic[$PYTHON_USEDEP] )
	webengine? ( dev-python/PyQtWebEngine[$PYTHON_USEDEP] )
"

DEPEND="
	${RDEPEND}
	${PDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}"/${PN}-3.8.5-fix-mpv.patch # Remove unused ytdl option
)

python_install_all() {
	distutils-r1_python_install_all

	domenu "${FILESDIR}/${PN}.desktop"
	newicon "${S}/feeluown/gui/assets/icons/feeluown.png" "${PN}.png"
}
