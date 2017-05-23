# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="https://github.com/houtianze/bypy.git"

inherit git-r3 distutils-r1
DESCRIPTION="Python client for Baidu Yun Cloud Storage"
HOMEPAGE="https://github.com/houtianze/bypy"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/requests[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
