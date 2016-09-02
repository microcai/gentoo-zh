# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Chinese text segmentation: built to be the best Python Chinese word segmentation module."
HOMEPAGE="https://github.com/fxsjy/jieba"

SRC_URI="https://github.com/fxsjy/jieba/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
