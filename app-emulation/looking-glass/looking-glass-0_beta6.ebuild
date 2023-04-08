# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake tmpfiles linux-info

MY_PV="${PV//0_beta/B}"

DESCRIPTION="A low latency KVMFR application for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.io"
SRC_URI="https://looking-glass.io/artifact/${MY_PV}/source -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X wayland pipewire pulseaudio +backtrace gnome host obs"
REQUIRED_USE="|| ( X wayland )
	|| ( pipewire pulseaudio )"

DEPEND="gui-libs/egl-wayland
	media-libs/fontconfig
	media-libs/libsamplerate
	dev-libs/nettle[gmp]
	app-emulation/spice-protocol
	X? (
		x11-libs/libX11
		x11-libs/libXfixes
		x11-libs/libXi
		x11-libs/libXScrnSaver
		x11-libs/libXpresent
	)
	wayland? (
		dev-libs/wayland
		x11-libs/libxkbcommon
		gnome? (
			gui-libs/libdecor
		)
	)
	pipewire? (
		media-video/pipewire
	)
	pulseaudio? (
		media-sound/pulseaudio
	)
	obs? (
		media-video/obs-studio
	)"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

MY_CMAKE_PROJECT="client "

src_prepare() {
	default
	# add other project
	if use host; then
		MY_CMAKE_PROJECT+="host "
	fi
	if use obs; then
		MY_CMAKE_PROJECT+="obs "
	fi
	# cmake prepare loop
	for prj in ${MY_CMAKE_PROJECT}
	do
		CMAKE_USE_DIR="${S}/${prj}"
		cmake_src_prepare "$@"
	done
}

src_configure() {
	# cmake configure by use flags
	if ! use X; then
		local mycmakeargs+=(
			-DENABLE_X11=no
		)
	fi
	if ! use wayland; then
		local mycmakeargs+=(
			-DENABLE_WAYLAND=no
		)
	fi
	if ! use pipewire; then
		local mycmakeargs+=(
			-DENABLE_PIPEWIRE=no
		)
	fi
	if ! use pulseaudio; then
		local mycmakeargs+=(
			-DENABLE_PULSEAUDIO=no
		)
	fi
	if use gnome && use wayland; then
		local mycmakeargs+=(
			-DENABLE_LIBDECOR=yes
		)
	fi
	# cmake configure loop
	for prj in ${MY_CMAKE_PROJECT}
	do
		CMAKE_USE_DIR="${S}/${prj}"
		BUILD_DIR="${CMAKE_USE_DIR}_build"
		cmake_src_configure "$@"
	done
	set_arch_to_kernel
}

src_compile() {
	# cmake compile loop
	for prj in ${MY_CMAKE_PROJECT}
	do
		CMAKE_USE_DIR="${S}/${prj}"
		BUILD_DIR="${CMAKE_USE_DIR}_build"
		cmake_src_compile "$@"
	done
}

src_install() {
	# install cmake projects
	for prj in ${MY_CMAKE_PROJECT}
	do
		CMAKE_USE_DIR="${S}/${prj}"
		BUILD_DIR="${CMAKE_USE_DIR}_build"
		cmake_src_install "$@"
	done
	# install docs
	einstalldocs
	# install tmpfiles config
	newtmpfiles "${FILESDIR}"/${PN}-tmpfiles.conf ${PN}.conf
}
