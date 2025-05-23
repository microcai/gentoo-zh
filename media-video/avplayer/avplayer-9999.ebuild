# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake git-r3

DESCRIPTION="avplayer is a p2p video downloader and player"
HOMEPAGE="http://avplayer.avplayer.org"

EGIT_REPO_URI="https://github.com/avplayer/avplayer.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND=">=dev-libs/boost-1.49[threads(+),static-libs(+)]
		dev-libs/openssl
		media-libs/libsdl"
RDEPEND="${DEPEND}"
