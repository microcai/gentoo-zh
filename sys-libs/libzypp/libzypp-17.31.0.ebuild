# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/openSUSE/libzypp.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
	KEYWORDS=""
else
	SRC_URI="https://github.com/openSUSE/libzypp/archive/refs/tags/${PV}.tar.gz -> libzypp-${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PV}"
fi

DESCRIPTION="ZYpp Package Management library"
HOMEPAGE="https://doc.opensuse.org/projects/libzypp/HEAD/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/libsolv
"
DEPEND="
	app-arch/rpm
	dev-libs/boost
	dev-libs/protobuf
	dev-ruby/asciidoctor
	<dev-cpp/yaml-cpp-0.7.0
	net-libs/libproxy
	app-doc/doxygen
	<dev-libs/libsigc++-3.0.7
	dev-python/graphviz
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DENABLE_BUILD_TRANS=ON
		-DENABLE_BUILD_TESTS=ON
		-DENABLE_BUILD_DOCS=OFF
		-DENABLE_ZSTD_COMPRESSION=ON
		-DENABLE_ZCHUNK_COMPRESSION=ON
		-DDISABLE_MEDIABACKEND_TESTS=ON
	)
	cmake_src_configure
}
