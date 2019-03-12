# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )

inherit distutils-r1

DESCRIPTION="Chinese text segmentation: built to be the best Python Chinese word segmentation module."

HOMEPAGE="https://github.com/fxsjy/jieba"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip -> ${P}.zip"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
