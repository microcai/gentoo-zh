# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A library of C++ coroutine abstractions for the coroutines TS"
HOMEPAGE="https://github.com/Garcia6l20/cppcoro"
EGIT_REPO_URI="https://github.com/Garcia6l20/${PN}.git"
EGIT_COMMIT=e1d53e6

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# currently, test is broken
IUSE="+shared"
RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-ins-into-lib64.patch
	"${FILESDIR}"/${PN}-include-utility.patch
)

src_configure() {
	mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DBUILD_SHARED_LIBS=$(usex shared ON OFF)
	)
	cmake_src_configure
}
