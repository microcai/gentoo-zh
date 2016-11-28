# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils git-r3

DESCRIPTION=" A note-taking KDE application with the power of lightweight markup language"
HOMEPAGE="https://github.com/sadhen/marketo"
EGIT_REPO_URI="https://github.com/sadhen/marketo.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake
	kde-frameworks/kdewebkit
	kde-frameworks/kfilemetadata
	kde-frameworks/ktexteditor
	kde-frameworks/extra-cmake-modules
	dev-libs/libmdcpp
	sys-devel/gcc[cxx]
"
RDEPEND="${DEPEND}"
