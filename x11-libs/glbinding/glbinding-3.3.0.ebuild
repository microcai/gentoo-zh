# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A C++ binding for the OpenGL API"
HOMEPAGE="https://glbinding.org/"
SRC_URI="https://github.com/cginternals/glbinding/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

inherit cmake-multilib

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="lto"

PATCHES=(
	"${FILESDIR}"/glbinding-fix-install.patch
)

src_configure(){
	mycmakeargs=(
		-DOPTION_BUILD_TOOLS=OFF
		-DOPTION_BUILD_EXAMPLES=OFF
		-DINSTALL_LIB=$(get_libdir)
		-DINSTALL_SHARED=$(get_libdir)
		-DOPTION_BUILD_WITH_LTO=$(usex lto ON OFF)
	)

	cmake-multilib_src_configure
}

src_install(){
	cmake-multilib_src_install
	# remove conflict files with libglvnd
	rm "${D}"/usr/include/KHR/khrplatform.h
}
