# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="a modern terminal emulator for Linux"
SRC_URI="https://github.com/mytbk/fqterm/archive/${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/mytbk/fqterm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/openssl
	media-libs/alsa-lib
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtmultimedia
	dev-qt/qtscript
	dev-qt/qtwidgets
	dev-qt/qtxml"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eapply "${FILESDIR}/${P}-drop-qt4.patch"
	eapply "${FILESDIR}/desktop.patch"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}
