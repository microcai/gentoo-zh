# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/openSUSE/libsolv.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
else
	SRC_URI="https://github.com/openSUSE/libsolv/archive/refs/tags/${PV}.tar.gz -> libsolv-${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PV}"
fi

DESCRIPTION="Library for solving packages and reading repositories"
HOMEPAGE="https://doc.opensuse.org/projects/libzypp/HEAD/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND="
	app-arch/zchunk
"
DEPEND="
	app-arch/rpm
	dev-lang/ruby
	dev-lang/tk
	dev-lang/swig
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_C_FLAGS_RELEASE='-DNDEBUG' \
		-DENABLE_PERL=ON
		-DENABLE_PYTHON=ON
		-DENABLE_RUBY=ON
		-DENABLE_TCL=ON
		-DUSE_VENDORDIRS=ON
		-DENABLE_RPMDB=ON
		-DENABLE_RPMPKG=ON
		-DENABLE_PUBKEY=ON
		-DENABLE_COMPLEX_DEPS=1
		-DENABLE_RPMDB_BYRPMHEADER=ON
		-DENABLE_RPMDB_LIBRPM=ON
		-DENABLE_RPMDB_BDB=ON
		-DENABLE_RPMPKG_LIBRPM=ON
		-DENABLE_RPMMD=ON
		-DENABLE_SUSEREPO=ON
		-DENABLE_COMPS=ON
		-DENABLE_HAIKU=OFF
		-DENABLE_HELIXREPO=ON
		-DENABLE_DEBIAN=ON
		-DENABLE_MDKREPO=ON
		-DENABLE_ARCHREPO=ON
		-DENABLE_CUDFREPO=ON
		-DENABLE_CONDA=ON
		-DENABLE_APPDATA=ON
		-DMULTI_SEMANTICS=ON
		-DENABLE_LZMA_COMPRESSION=ON
		-DENABLE_BZIP2_COMPRESSION=ON
		-DENABLE_ZSTD_COMPRESSION=ON
		-DENABLE_ZCHUNK_COMPRESSION=ON
		-DWITH_SYSTEM_ZCHUNK=ON
		-DWITH_LIBXML2=ON
	)
	cmake_src_configure
}
