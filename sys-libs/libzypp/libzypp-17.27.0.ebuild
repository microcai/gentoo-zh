# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

SRC_URI="https://github.com/openSUSE/libzypp/archive/refs/tags/${PV}.tar.gz -> libzypp-${PV}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="ZYpp Package Management library"
HOMEPAGE="https://doc.opensuse.org/projects/libzypp/HEAD/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	dev-libs/boost
	app-crypt/gpgme
	net-libs/libproxy
	dev-libs/libsigc++:2
	sys-apps/systemd
	dev-libs/libxml2
	dev-cpp/yaml-cpp
	sys-libs/libsolv
"
BDEPEND="${DEPEND}
	app-text/asciidoc
	dev-util/cmake
	dev-util/dejagnu
	app-doc/doxygen
	dev-libs/expat
	dev-vcs/git
	app-crypt/gnupg
	media-gfx/graphviz
	dev-util/ninja
	dev-util/rpmdevtools
"

S="${WORKDIR}/${PN}-${PV}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_DRI_LIB="$(get_libdir)/${P}"
		-DCMAKE_SKIP_RPATH=1
		-DDISABLE_MEDIABACKEND_TESTS=ON
		-DENABLE_BUILD_DOCS=ON
		-DENABLE_BUILD_TRANS=ON
		-DENABLE_BUILD_TESTS=ON
		-DENABLE_ZCHUNK_COMPRESSION=ON
		-DENABLE_ZSTD_COMPRESSION=ON
	)
	cmake_src_configure
}
