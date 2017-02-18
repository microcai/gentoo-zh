# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1 python-r1 git-r3

DESCRIPTION="A library for parsing and manipulating Advanced SubStation Alpha subtitle files."
HOMEPAGE="https://github.com/rfw/python-ass"
EGIT_REPO_URI="https://github.com/rfw/python-ass.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="
     ${PYTHON_REQUIRED_USE}"

