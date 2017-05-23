# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="科学操长城软件"
HOMEPAGE="https://github.com/avplayer/avsocks"
SRC_URI=""

inherit cmake-utils git-2

EGIT_REPO_URI="https://github.com/avplayer/avsocks.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/boost
	dev-libs/openssl
	"
RDEPEND="${DEPEND}"

