# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="a modern terminal emulator for Linux"
EGIT_REPO_URI="https://github.com/mytbk/fqterm.git"
HOMEPAGE="https://github.com/mytbk/fqterm"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/openssl
	media-libs/alsa-lib
	dev-qt/qtcore[ssl,qt3support]
	dev-qt/qtgui"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-as-needed.patch"
}
