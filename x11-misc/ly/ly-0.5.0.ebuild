# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"
EGIT_REPO_URI="https://github.com/OriPoin/ly.git"
EGIT_SUBMODULES=( '*' )

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-devel/gcc
		sys-devel/make
		sys-libs/pam
		x11-libs/libxcb
		x11-base/xorg-server
		x11-apps/xauth"
RDEPEND="${DEPEND}"
BDEPEND=""

