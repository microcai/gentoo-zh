# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="avim is a secure IM build around RSA"
HOMEPAGE="http://avim.avplayer.org"
SRC_URI=""

EGIT_REPO_URI="https://github.com/avplayer/avim.git"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/protobuf
	dev-libs/openssl
	>=dev-libs/boost-1.57[context,threads]
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	"

DEPEND="${RDEPEND}
	>=dev-util/cmake-3.1
	>=sys-devel/gcc-4.8"



