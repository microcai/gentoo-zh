# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="天涯小说搜索神器"
HOMEPAGE="https://gitcafe.com/avplayer/tianya"
SRC_URI=""
EGIT_REPO_URI="git://gitcafe.com/avplayer/tianya.git"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-qt/qtwidgets-5.4:5
  dev-libs/boost[context,threads]"

RDEPEND="${DEPEND}"

