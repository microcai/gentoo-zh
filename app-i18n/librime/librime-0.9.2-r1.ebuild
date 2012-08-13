# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils vcs-snapshot
DESCRIPTION="Rime Input Method Engine library"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="https://github.com/lotem/${PN}/tarball/rime-${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	app-i18n/opencc
	dev-cpp/glog
	dev-db/kyotocabinet
	dev-cpp/yaml-cpp
	>=dev-libs/boost-1.46.0
	sys-libs/zlib
	x11-proto/xproto"
DEPEND="${RDEPEND}"

src_prepare() {
	# patch the cmake system to make it disable data resource build
	epatch "${FILESDIR}"/${PN}-data-option.patch
	# change path from rime-data to rime/data, make it more consist
	sed -i -e 's|/rime-data|/rime/data|g' CMakeLists.txt Makefile || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build static-libs STATIC)
		-DBUILD_DATA=OFF
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "Since we try to seperate the rime data from this ebuild"
	elog "Please do make sure you do following to make rime work"
	elog " $ emerge brise"
}
