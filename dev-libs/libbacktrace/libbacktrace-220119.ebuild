# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="A C library for producing symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/ianlancetaylor/libbacktrace.git"
EGIT_COMMIT=332522e

LICENSE="BSD"
SLOT="0"

IUSE="static-libs"
RESTRICT="mirror"

RDEPEND="
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND=""

src_configure() {
	econf --enable-shared $(use_enable static-libs static)
}
