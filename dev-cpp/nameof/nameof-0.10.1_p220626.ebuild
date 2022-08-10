# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Nameof operator for modern C++"
HOMEPAGE="https://github.com/Neargye/nameof"
EGIT_REPO_URI="https://github.com/CHN-beta/nameof.git"
EGIT_COMMIT=b6a4452

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
RESTRICT="mirror"

src_install() {
	doheader include/nameof.hpp
	if use doc
	then
		dodoc doc/limitations.md doc/reference.md
	fi
}
