# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib flag-o-matic

DESCRIPTION="SDL2 compat layer over SDL3"
HOMEPAGE="https://libsdl.org/"
SRC_URI="https://github.com/libsdl-org/sdl2-compat/releases/download/release-${PV}/sdl2-compat-${PV}.zip"

S="${WORKDIR}/sdl2-compat-${PV}"

LICENSE="ZLIB"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

IUSE="alsa aqua dbus fcitx gles1 gles2 +haptic ibus jack +joystick kms libsamplerate nas opengl oss pipewire pulseaudio sndio +sound static-libs test udev +video vulkan wayland X xscreensaver"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	alsa? ( sound )
	fcitx? ( dbus )
	gles1? ( video )
	gles2? ( video )
	haptic? ( joystick )
	ibus? ( dbus )
	jack? ( sound )
	nas? ( sound )
	opengl? ( video )
	pulseaudio? ( sound )
	sndio? ( sound )
	test? ( static-libs )
	vulkan? ( video )
	wayland? ( gles2 )
	xscreensaver? ( X )
"

COMMON_DEPEND="
	media-libs/libsdl3[vulkan?,wayland?,opengl?,jack?,ibus?,video?,sound?,dbus?,joystick?,abi_x86_32?]
	!media-libs/libsdl2:0
"
RDEPEND="
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
"
BDEPEND="
	virtual/pkgconfig
	wayland? ( >=dev-util/wayland-scanner-1.20 )
"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/SDL2/SDL_config.h
	/usr/include/SDL2/SDL_platform.h
	/usr/include/SDL2/begin_code.h
	/usr/include/SDL2/close_code.h
)

src_configure() {
	local mycmakeargs=(
		-DSDL_STATIC=$(usex static-libs)
		-DSDL_SYSTEM_ICONV=ON
		-DSDL_GCC_ATOMICS=ON
		-DSDL_AUDIO=$(usex sound)
		-DSDL_VIDEO=$(usex video)
		-DSDL_JOYSTICK=$(usex joystick)
		-DSDL_HAPTIC=$(usex haptic)
		-DSDL_POWER=ON
		-DSDL_FILESYSTEM=ON
		-DSDL_TIMERS=ON
		-DSDL_FILE=ON
		-DSDL_LOADSO=ON
		-DSDL_ASSEMBLY=ON
		-DSDL_OSS=$(usex oss)
		-DSDL_ALSA=$(usex alsa)
		-DSDL_ALSA_SHARED=OFF
		-DSDL_JACK=$(usex jack)
		-DSDL_JACK_SHARED=OFF
		-DSDL_ESD=OFF
		-DSDL_PIPEWIRE=$(usex pipewire)
		-DSDL_PIPEWIRE_SHARED=OFF
		-DSDL_PULSEAUDIO=$(usex pulseaudio)
		-DSDL_PULSEAUDIO_SHARED=OFF
		-DSDL_ARTS=OFF
		-DSDL_LIBSAMPLERATE=$(usex libsamplerate)
		-DSDL_LIBSAMPLERATE_SHARED=OFF
		-DSDL_WERROR=OFF
		-DSDL_NAS=$(usex nas)
		-DSDL_NAS_SHARED=OFF
		-DSDL_SNDIO=$(usex sndio)
		-DSDL_SNDIO_SHARED=OFF
		-DSDL_DISKAUDIO=$(usex sound)
		-DSDL_DUMMYAUDIO=$(usex sound)
		-DSDL_WAYLAND=$(usex wayland)
		-DSDL_WAYLAND_SHARED=OFF
		-DSDL_WAYLAND_LIBDECOR=$(usex wayland)
		-DSDL_WAYLAND_LIBDECOR_SHARED=OFF
		-DSDL_RPI=OFF
		-DSDL_X11=$(usex X)
		-DSDL_X11_SHARED=OFF
		-DSDL_X11_XSCRNSAVER=$(usex xscreensaver)
		-DSDL_COCOA=$(usex aqua)
		-DSDL_DIRECTFB=OFF
		-DSDL_FUSIONSOUND=OFF
		-DSDL_KMSDRM=$(usex kms)
		-DSDL_KMSDRM_SHARED=OFF
		-DSDL_DUMMYVIDEO=$(usex video)
		-DSDL_OPENGL=$(usex opengl)
		-DSDL_OPENGLES=$(use gles1 || use gles2 && echo ON || echo OFF)
		-DSDL_VULKAN=$(usex vulkan)
		-DSDL_LIBUDEV=$(usex udev)
		-DSDL_DBUS=$(usex dbus)
		-DSDL_IBUS=$(usex ibus)
		-DSDL_CCACHE=OFF
		-DSDL_DIRECTX=OFF
		-DSDL_RPATH=OFF
		-DSDL_VIDEO_RENDER_D3D=OFF
		-DSDL_TESTS=$(usex test)
	)
	cmake-multilib_src_configure
}

src_compile() {
	multilib-minimal_src_compile
}

src_test() {
	unset SDL_GAMECONTROLLERCONFIG SDL_GAMECONTROLLER_USE_BUTTON_LABELS
	cmake-multilib_src_test
}

multilib_src_install_all() {
	rm -r "${ED}"/usr/share/licenses/ || die
	dodoc {BUGS,COMPATIBILITY,HOW_TO_TEST_GAMES}.md README.md
}

pkg_postinst() {
	einfo "If you are using steam,"
	einfo "Before launching,"
	einfo "please set the LD_PRELOAD environment variable to"
	einfo "${EPREFIX}/usr/$(ABI=x86 get_libdir)/libSDL3.so"
}