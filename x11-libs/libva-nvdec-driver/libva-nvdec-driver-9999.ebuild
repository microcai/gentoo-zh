# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NVDEC Backend for Video Acceleration (VA) API"
HOMEPAGE="https://github.com/elFarto/nvidia-vaapi-driver"

if [[ ${PV} != *9999* ]] ; then
	EGIT_COMMIT=v${PV}
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/elFarto/nvidia-vaapi-driver/archive/v${PV}/libva-nvidia-driver-${PV}.tar.gz -> ${P}.tar.gz"

	S="${WORKDIR}/nvidia-vaapi-driver-${PV}"
else
	EGIT_REPO_URI="https://github.com/elFarto/nvidia-vaapi-driver.git"
	KEYWORDS=""
	inherit git-r3
fi

inherit meson

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=media-libs/libva-2.16
    >=media-libs/gstreamer-1.0
    >=media-libs/gst-plugins-bad-1.0
	>=media-libs/libglvnd-1.6.0
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
    >=media-libs/nv-codec-headers-11.1.5.1
"

PATCHES=(
	"${FILESDIR}/01-install-path.patch"
)
