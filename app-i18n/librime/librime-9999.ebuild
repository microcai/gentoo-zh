# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2
DESCRIPTION="Rime Input Method Engine library"
HOMEPAGE="http://code.google.com/p/rimeime/"
EGIT_REPO_URI="git://github.com/lotem/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
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

S=${WORKDIR}/${PN}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build static-libs STATIC)
		-DBUILD_DATA=OFF
	)
	cmake-utils_src_configure
}
