# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A somewhat comprehensive collection of Chinese Linux man pages"
HOMEPAGE="https://github.com/man-pages-zh/manpages-zh"

RESTRICT="mirror"
SRC_URL=""

EGIT_REPO_URI="https://github.com/man-pages-zh/manpages-zh"

LICENSE="FDL-1.2"
SLOT="0"

RDEPEND="virtual/man
	>=sys-apps/man-pages-3.83
"

DEPEND="
	app-i18n/opencc
"

inherit  git-r3 cmake

src_configure() {
	local mycmakeargs=(
		-DENABLE_ZHCN=ON
		-DENABLE_ZHTW=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm "${ED}"/usr/share/man/zh_CN/man1/groups.1 || die
	dodoc README* DOCS/*
}
