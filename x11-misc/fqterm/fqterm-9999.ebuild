# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit cmake-utils git-r3

DESCRIPTION="a modern terminal emulator for Linux"
EGIT_REPO_URI="https://github.com/mytbk/fqterm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/openssl
	media-libs/alsa-lib
	dev-qt/qtcore[ssl,qt3support]
	dev-qt/qtgui"
DEPEND="${RDEPEND}"

src_install() {
	cmake-utils_src_install
}

src_prepare() {
	epatch "${FILESDIR}/${P}-as-needed.patch"
}
