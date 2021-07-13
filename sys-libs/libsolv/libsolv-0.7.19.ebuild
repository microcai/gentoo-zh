# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

SRC_URI="https://github.com/openSUSE/libsolv/archive/refs/tags/${PV}.tar.gz -> libsolv-${PV}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="Library for solving packages and reading repositories"
HOMEPAGE="https://doc.opensuse.org/projects/libzypp/HEAD/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	app-arch/bzip2
	dev-libs/expat
	dev-util/rpmdevtools
	app-arch/xz-utils
	app-arch/zchunk
	sys-libs/zlib
	app-arch/zstd
"
BDEPEND="${DEPEND}
	dev-util/cmake
	dev-lang/perl
	dev-lang/python
	dev-lang/ruby
	dev-lang/swig
"

S="${WORKDIR}/${PN}-${PV}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_C_FLAGS_RELEASE='-DNDEBUG'
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DCMAKE_DRI_LIB="$(get_libdir)/${P}"
		-DUSE_VENDORDIRS=ON
		-DFEDORA=1
		-DENABLE_APPDATA=ON
		-DENABLE_ARCHREPO=ON
		-DENABLE_BZIP2_COMPRESSION=ON
		-DENABLE_COMPLEX_DEPS=1
		-DENABLE_COMPS=ON
		-DENABLE_CONDA=ON
		-DENABLE_CUDFREPO=ON
		-DENABLE_DEBIAN=ON
		-DENABLE_HAIKU=OFF
		-DENABLE_HELIXREPO=ON
		-DENABLE_LZMA_COMPRESSION=ON
		-DENABLE_MDKREPO=ON
		-DENABLE_PERL=ON
		-DENABLE_PUBKEY=ON
		-DENABLE_PYTHON=ON
		-DENABLE_RPMDB=ON
		-DENABLE_RPMDB_BYRPMHEADER=ON
		-DENABLE_RPMDB_LIBRPM=ON
		-DENABLE_RPMMD=ON
		-DENABLE_RPMPKG=ON
		-DENABLE_RUBY=ON
		-DENABLE_SUSEREPO=ON
		-DENABLE_TCL=OFF
		-DENABLE_ZCHUNK_COMPRESSION=ON
		-DWITH_SYSTEM_ZCHUNK=ON
		-DENABLE_ZSTD_COMPRESSION=ON
		-DMULTI_SEMANTICS=ON
		-DWITH_LIBXML2=OFF
	)
	cmake_src_configure
}
