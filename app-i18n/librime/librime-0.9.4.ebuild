# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils multilib vcs-snapshot

DESCRIPTION="Rime Input Method Engine library"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="http://rimeime.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="app-i18n/opencc
	dev-cpp/glog
	dev-cpp/yaml-cpp
	dev-db/kyotocabinet
	>=dev-libs/boost-1.46.0
	sys-libs/zlib
	x11-proto/xproto"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build static-libs STATIC)
		-DBUILD_DATA=OFF
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
	)
	cmake-utils_src_configure
}
