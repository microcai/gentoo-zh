# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# workaround for compatibility with cmake 4, bugs #951350
CMAKE_QA_COMPAT_SKIP=yes

inherit cmake

DESCRIPTION="a modern terminal emulator for Linux"
HOMEPAGE="https://github.com/mytbk/fqterm"
SRC_URI="https://github.com/mytbk/fqterm/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/openssl
	media-libs/alsa-lib
	dev-qt/linguist-tools:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5"
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
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 # bugs #951350
	)
	cmake_src_configure
}
