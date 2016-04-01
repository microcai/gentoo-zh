# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils git-r3

DESCRIPTION="implementation of the Markdown markup language in CPP (library)"
HOMEPAGE="https://github.com/sadhen/libmdcpp/"
EGIT_REPO_URI="https://github.com/sadhen/libmdcpp.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake
	dev-libs/boost
	sys-devel/gcc[cxx]
"
RDEPEND="${DEPEND}"
