# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

inherit distutils-r1

DESCRIPTION="Chinese text segmentation: built to be the best Python Chinese word segmentation module."

HOMEPAGE="https://github.com/fxsjy/jieba"
#SRC_URI="https://github.com/fxsjy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://pypi.python.org/packages/f6/86/9e721cc52075a07b7d07eb12bcb5dde771d35332a3dae1e14ae4290a197a/${P}.zip -> ${P}.zip"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
