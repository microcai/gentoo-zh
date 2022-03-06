# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit meson distutils-r1 multilib-minimal

MY_PN="MangoHud"
MY_PV="${PV}-1"
IMGUI_V="1.81"
IMGUI_WARP_V="1"
SPDLOG_V="1.8.5"
SPDLOG_WARP_V="1"

DESCRIPTION="A Vulkan & OpenGL overlay for monitoring FPS,temperatures,CPU/GPU load and more."
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
SRC_URI="
	https://github.com/flightlessmango/${MY_PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz
	https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_V}.tar.gz -> imgui-${IMGUI_V}.tar.gz
	https://wrapdb.mesonbuild.com/v1/projects/imgui/${IMGUI_V}/${IMGUI_WARP_V}/get_zip -> imgui-${IMGUI_V}-${IMGUI_WARP_V}-warp.zip
	https://github.com/gabime/spdlog/archive/refs/tags/v${SPDLOG_V}.tar.gz -> spdlog-${SPDLOG_V}.tar.gz
	https://wrapdb.mesonbuild.com/v1/projects/spdlog/${SPDLOG_V}/${SPDLOG_WARP_V}/get_zip -> spdlog-${SPDLOG_V}-${SPDLOG_WARP_V}-warp.zip
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+dbus +X xnvctrl wayland video_cards_nvidia video_cards_amdgpu"
REQUIRED_USE="
	xnvctrl? ( video_cards_nvidia )
"

BDEPEND="
	app-arch/unzip
	dev-python/mako[${PYTHON_USEDEP}]
	dev-util/ninja
"
DEPEND="
	dev-util/glslang
	>=dev-util/vulkan-headers-1.2
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	video_cards_amdgpu? (
		x11-libs/libdrm[video_cards_amdgpu]
	)
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_unpack() {
	default

	mv imgui-1.81 "${S}"/subprojects || die
	mv spdlog-1.8.5 "${S}"/subprojects || die
}

multilib_src_configure() {
	local emesonargs=(
		-Dappend_libdir_mangohud=false
		-Duse_system_vulkan=enabled
		-Dinclude_doc=false
		$(meson_feature video_cards_nvidia with_nvml)
		$(meson_feature video_cards_amdgpu with_libdrm_amdgpu)
		$(meson_feature xnvctrl with_xnvctrl)
		$(meson_feature X with_x11)
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
	)
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	dodoc "${S}/bin/MangoHud.conf"

	einstalldocs
}

pkg_postinst() {
	if ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi
}
