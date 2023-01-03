# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A date and time library based on the C++11/14/17 <chrono> header"
HOMEPAGE="https://github.com/HowardHinnant/date"
EGIT_REPO_URI="https://github.com/HowardHinnant/date.git"
EGIT_COMMIT=e6f4aed
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

src_install() {
	doheader -r include/date
	mkdir -p "${D}/usr/src" || die
	cp -r src "${D}/usr/src/date" || die
}
