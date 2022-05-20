# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NVDEC Backend for Video Acceleration (VA) API"
HOMEPAGE="https://github.com/elFarto/nvidia-vaapi-driver"

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/elFarto/nvidia-vaapi-driver.git"
	inherit git-r3
else
    SRC_URI=""
fi

inherit meson

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=x11-libs/libva-1.8.0
    >=media-libs/nv-codec-headers-11.1.5.1
    >=media-libs/gstreamer-1.0
    media-libs/gst-plugins-bad
	media-libs/libglvnd
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/01-install-path.patch"
)
