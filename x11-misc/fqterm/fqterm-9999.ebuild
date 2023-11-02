# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="a modern terminal emulator for Linux"
EGIT_REPO_URI="https://github.com/mytbk/fqterm.git"
HOMEPAGE="https://github.com/mytbk/fqterm"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/openssl
	media-libs/alsa-lib
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtscript:5"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}
