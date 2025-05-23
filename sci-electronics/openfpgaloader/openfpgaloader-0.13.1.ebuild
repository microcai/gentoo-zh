# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Universal utility for programming FPGAs"
HOMEPAGE="https://trabucayre.github.io/openFPGALoader"
SRC_URI="https://github.com/trabucayre/openFPGALoader/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
MY_PN="openFPGALoader"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cmsisdap +gpio remote static"

DEPEND="
	dev-libs/libgpiod
	dev-libs/libusb
	sys-libs/libcap
	sys-libs/zlib
	dev-embedded/libftdi
	cmsisdap? ( dev-libs/hidapi )
"
RDEPEND="${DEPEND}"

src_configure() {

	# TODO: -DISE_DIR
	# TODO: _DBLASTERII_DIR
	local mycmakeargs=(
		-DENABLE_UDEV="on"
		-DENABLE_CMSISDAP=$(usex cmsisdap)
		-DENABLE_LIBGPIOD=$(usex gpio)
		-DENABLE_REMOTEBITBANG=$(usex remote)
		-DBUILD_STATIC=$(usex static)
	)
	cmake_src_configure
}
