# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

EGIT_COMMIT="59d63ca82813597ca3bd045edc11c1884774ada9"
EGIT_REPO_URI="git://github.com/zhanlangsir/Qtqq.git"

DESCRIPTION="Tencent QQ written in Qt"
HOMEPAGE="as-is"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtgui
       dev-qt/qtsql
       dev-qt/qtwebkit"
RDEPEND="${DEPEND}"

