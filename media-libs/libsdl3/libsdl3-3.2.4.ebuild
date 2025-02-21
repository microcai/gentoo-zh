# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

# PHASH="d95f5bad2459608816cbf24f14dcab618a4a9ab7"

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="https://libsdl.org/"
SRC_URI="https://github.com/libsdl-org/SDL/releases/download/release-${PV}/SDL3-${PV}.zip"

LICENSE="ZLIB"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

IUSE="
	+sound +video webcam +joystick +haptic +hidapi

	cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_avx512f cpu_flags_x86_mmx
	cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3 cpu_flags_x86_sse4_1 cpu_flags_x86_sse4_2
	cpu_flags_ppc_altivec
	cpu_flags_arm_simd cpu_flags_arm_neon
	cpu_flags_loong_lsx cpu_flags_loong_lasx
	video_cards_vc4 video_cards_rockchip video_cards_vivante

	dbus ibus opengl gles +threads
	oss alsa jack pipewire pulseaudio sndio
	X xscreensaver wayland libdecor vulkan kms
	hidapi libusb udev
	pic static-libs test
"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	alsa? ( sound )
	jack? ( sound )
	oss? ( sound )
	pulseaudio? ( sound )
	sndio? ( sound )
	X? ( video )
	webcam? ( video )
	gles? ( video )
	kms? ( video )
	opengl? ( video )
	video_cards_rockchip? ( video )
	video_cards_vc4? ( video )
	vulkan? ( video )
	wayland? ( video )
	xscreensaver? ( X )
	libdecor? ( wayland )
	static-libs? ( pic )
"

DEPEND="
	virtual/libiconv[${MULTILIB_USEDEP}]
	alsa? ( >=media-libs/alsa-lib-1.0.27.2[${MULTILIB_USEDEP}] )
	dbus? ( >=sys-apps/dbus-1.6.18-r1[${MULTILIB_USEDEP}] )
	gles? ( >=media-libs/mesa-9.1.6[${MULTILIB_USEDEP},gles2(+),gles2(+)] )
	ibus? ( app-i18n/ibus )
	jack? ( virtual/jack[${MULTILIB_USEDEP}] )
	kms? (
		>=x11-libs/libdrm-2.4.82[${MULTILIB_USEDEP}]
		>=media-libs/mesa-9.0.0[${MULTILIB_USEDEP},gbm(+)]
	)
	opengl? (
		>=virtual/opengl-7.0-r1[${MULTILIB_USEDEP}]
		>=virtual/glu-9.0-r1[${MULTILIB_USEDEP}]
	)
	pipewire? ( media-video/pipewire:=[${MULTILIB_USEDEP}] )
	pulseaudio? ( media-libs/libpulse[${MULTILIB_USEDEP}] )
	sndio? ( media-sound/sndio:=[${MULTILIB_USEDEP}] )
	udev? ( >=virtual/libudev-208:=[${MULTILIB_USEDEP}] )
	wayland? (
		>=dev-libs/wayland-1.20[${MULTILIB_USEDEP}]
		>=media-libs/mesa-9.1.6[${MULTILIB_USEDEP},egl(+),gles2(+),wayland]
		>=x11-libs/libxkbcommon-0.2.0[${MULTILIB_USEDEP}]
	)
	X? (
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXcursor-1.1.14[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXfixes-6.0.0[${MULTILIB_USEDEP}]
		>=x11-libs/libXi-1.7.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXrandr-1.4.2[${MULTILIB_USEDEP}]
		xscreensaver? ( >=x11-libs/libXScrnSaver-1.2.2-r1[${MULTILIB_USEDEP}] )
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/SDL3-${PV}"

multilib_src_configure() {
	local mycmakeargs=(
		-DSDL_AUDIO=$(usex sound ON OFF)
		-DSDL_VIDEO=$(usex video ON OFF)
		-DSDL_RENDER=ON
		-DSDL_CAMERA=$(usex webcam ON OFF)
		-DSDL_JOYSTICK=$(usex joystick ON OFF)
		-DSDL_HAPTIC=$(usex haptic ON OFF)
		-DSDL_HIDAPI=$(usex hidapi ON OFF)
		-DSDL_POWER=ON
		-DSDL_SENSOR=ON
		-DSDL_DIALOG=ON

		-DSDL_ASSEMBLY=ON
		-DSDL_AVX=$(usex cpu_flags_x86_avx ON OFF)
		-DSDL_AVX2=$(usex cpu_flags_x86_avx2 ON OFF)
		-DSDL_AVX512F=$(usex cpu_flags_x86_avx512f ON OFF)
		-DSDL_SSE=$(usex cpu_flags_x86_sse ON OFF)
		-DSDL_SSE2=$(usex cpu_flags_x86_sse2 ON OFF)
		-DSDL_SSE3=$(usex cpu_flags_x86_sse3 ON OFF)
		-DSDL_SSE4_1=$(usex cpu_flags_x86_sse4_1 ON OFF)
		-DSDL_SSE4_2=$(usex cpu_flags_x86_sse4_2 ON OFF)
		-DSDL_MMX=$(usex cpu_flags_x86_mmx ON OFF)
		-DSDL_ALTIVEC=$(usex cpu_flags_ppc_altivec ON OFF)
		-DSDL_ARMSIMD=$(usex cpu_flags_arm_simd ON OFF)
		-DSDL_ARMNEON=$(usex cpu_flags_arm_neon ON OFF)
		-DSDL_LSX=$(usex cpu_flags_loong_lsx ON OFF)
		-DSDL_LASX=$(usex cpu_flags_loong_lasx ON OFF)

		-DSDL_LIBC=ON
		-DSDL_SYSTEM_ICONV=ON
		-DSDL_LIBICONV=ON
		-DSDL_GCC_ATOMICS=ON
		-DSDL_DBUS=$(usex dbus ON OFF)
		-DSDL_DISKAUDIO=$(usex sound ON OFF)
		-DSDL_DUMMYAUDIO=$(usex sound ON OFF)
		-DSDL_DUMMYVIDEO=$(usex video ON OFF)
		-DSDL_IBUS=$(usex ibus ON OFF)
		-DSDL_OPENGL=$(usex opengl ON OFF)
		-DSDL_OPENGLES=$(usex gles ON OFF)
		-DSDL_PTHREADS=$(usex threads ON OFF)
		-DSDL_PTHREADS_SEM=$(usex threads ON OFF)
		-DSDL_OSS=$(usex oss ON OFF)
		-DSDL_ALSA=$(usex alsa ON OFF)
		-DSDL_ALSA_SHARED=OFF
		-DSDL_JACK=$(usex jack ON OFF)
		-DSDL_JACK_SHARED=OFF
		-DSDL_PIPEWIRE=$(usex pipewire ON OFF)
		-DSDL_PIPEWIRE_SHARED=OFF
		-DSDL_PULSEAUDIO=$(usex pulseaudio ON OFF)
		-DSDL_PULSEAUDIO_SHARED=OFF
		-DSDL_SNDIO=$(usex sndio ON OFF)
		-DSDL_SNDIO_SHARED=OFF
		-DSDL_RPATH=OFF
		-DSDL_CLOCK_GETTIME=ON
		-DSDL_X11=$(usex X ON OFF)
		-DSDL_X11_SHARED=OFF
		-DSDL_X11_XCURSOR=$(usex X ON OFF)
		-DSDL_X11_XDBE=$(usex X ON OFF)
		-DSDL_X11_XINPUT=$(usex X ON OFF)
		-DSDL_X11_XFIXES=$(usex X ON OFF)
		-DSDL_X11_XRANDR=$(usex X ON OFF)
		-DSDL_X11_XSCRNSAVER=$(usex xscreensaver ON OFF)
		-DSDL_X11_XSHAPE=$(usex X ON OFF)
		-DSDL_WAYLAND=$(usex wayland ON OFF)
		-DSDL_WAYLAND_SHARED=OFF
		-DSDL_WAYLAND_LIBDECOR=$(usex libdecor ON OFF)
		-DSDL_WAYLAND_LIBDECOR_SHARED=OFF
		-DSDL_RPI=$(usex video_cards_vc4 ON OFF)
		-DSDL_ROCKCHIP=$(usex video_cards_rockchip ON OFF)
		-DSDL_RENDER_D3D=OFF
		-DSDL_VIVANTE=$(usex video_cards_vivante ON OFF)
		-DSDL_VULKAN=$(usex vulkan ON OFF)
		-DSDL_RENDER_VULKAN=$(usex vulkan ON OFF)
		-DSDL_KMSDRM=$(usex kms ON OFF)
		-DSDL_KMSDRM_SHARED=OFF
		-DSDL_OFFSCREEN=ON
		-DSDL_DUMMYCAMERA=$(usex webcam ON OFF)
		-DSDL_HIDAPI=$(usex hidapi ON OFF)
		-DSDL_HIDAPI_LIBUSB=$(usex libusb ON OFF)
		-DSDL_HIDAPI_LIBUSB_SHARED=ON
		-DSDL_HIDAPI_JOYSTICK=$(usex joystick ON OFF)
		-DSDL_VIRTUAL_JOYSTICK=$(usex joystick ON OFF)
		-DSDL_LIBUDEV=$(usex udev ON OFF)
		-DSDL_ASAN=OFF
		-DSDL_CCACHE=OFF
		-DSDL_CLANG_TIDY=OFF

		-DSDL_SHARED=ON
		-DSDL_STATIC=$(usex static-libs ON OFF)
		-DSDL_TEST_LIBRARY=$(usex test ON OFF)

		-DSDL_TESTS=$(usex test ON OFF)
		-DSDL_INSTALL_TESTS=$(usex test ON OFF)
		-DSDL_TESTS_LINK_SHARED=$(usex test ON OFF)
	)

	cmake_src_configure
}