# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 cmake

DESCRIPTION="Modern C++ Terminal Emulator"
HOMEPAGE="https://github.com/contour-terminal/contour"
SRC_URI="
		https://github.com/contour-terminal/contour/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

IUSE="-test -debug +boost kde"

DEPEND="
		boost? ( dev-libs/boost )
		dev-cpp/yaml-cpp
		dev-qt/qtcore
		dev-qt/qtgui
		dev-qt/qtnetwork
		dev-qt/qtopengl
		kde-frameworks/extra-cmake-modules
		kde? ( kde-frameworks/kwindowsystem )
		media-libs/fontconfig
		media-libs/freetype
		media-libs/harfbuzz
		sys-libs/ncurses
		"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/disable_generate_terminfo.patch"
)

src_unpack() {
	default
	if use test ;then
		THIRDPARTIES="catch2 fmt range_v3 yaml_cpp termbenchpro libunicode GSL"
	else
		THIRDPARTIES="fmt range_v3 yaml_cpp termbenchpro libunicode GSL"
	fi

	for MY_REPO_NAME in ${THIRDPARTIES} ; do
		EGIT_REPO_URI="https://github.com/$(grep -A 2 "NAME ${MY_REPO_NAME}" ${S}/cmake/ThirdParties.cmake | grep GITHUB | awk -F '"' '{print $2F}')"
		EGIT_COMMIT=$(grep "${MY_REPO_NAME}: commit hash" ${S}/cmake/ThirdParties.cmake | awk -F '"' '{print $2F}')
		git-r3_fetch ${EGIT_REPO_URI}
		git-r3_checkout ${EGIT_REPO_URI} "${WORKDIR}/${MY_REPO_NAME}-src"
	done

}

src_configure() {

	append-cxxflags "-fPIC"

	if ! use debug; then
		CMAKE_BUILD_TYPE="Release"
	fi

	if use test; then
		FETCHCONTENT_SOURCE_DIR_CATCH2="${WORKDIR}/catch2-src"
	fi

	local mycmakeargs=(
		-GNinja \
		-DCMAKE_SKIP_RPATH=ON \
		-DYAML_BUILD_SHARED_LIBS=OFF \
		-DYAML_CPP_BUILD_CONTRIB=OFF \
		-DYAML_CPP_BUILD_TESTS=OFF \
		-DYAML_CPP_BUILD_TOOLS=OFF \
		-DYAML_CPP_INSTALL=OFF \
		-DCONTOUR_BLUR_PLATFORM_KWIN="$(usex kde)" \
		-DUSE_BOOST_FILESYSTEM="$(usex boost)" \
		-DCONTOUR_TESTING="$(usex test)" \
		-DCRISPY_TESTING="$(usex test)" \
		-DLIBTERMINAL_TESTING="$(usex test)" \
		-DFETCHCONTENT_SOURCE_DIR_FMT="${WORKDIR}/fmt-src"
		-DFETCHCONTENT_SOURCE_DIR_RANGE_V3="${WORKDIR}/range_v3-src"
		-DFETCHCONTENT_SOURCE_DIR_YAML_CPP="${WORKDIR}/yaml_cpp-src"
		-DFETCHCONTENT_SOURCE_DIR_TERMBENCHPRO="${WORKDIR}/termbenchpro-src"
		-DFETCHCONTENT_SOURCE_DIR_LIBUNICODE="${WORKDIR}/libunicode-src"
		-DFETCHCONTENT_SOURCE_DIR_GSL="${WORKDIR}/GSL-src/"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install $@
	dolib.so "${BUILD_DIR}/src/contour/opengl/libcontour_frontend_opengl.so"
	dolib.so "${BUILD_DIR}/src/crispy/libcrispy-core.so"
}
