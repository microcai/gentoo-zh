# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GN_MIN_VER=0.2165
# chromium-tools/get-chromium-toolchain-strings.py
TEST_FONT=f26f29c9d3bfae588207bbc9762de8d142e58935c62a86f67332819b15203b35

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW"

LLVM_COMPAT=( 18 19 )
PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE="xml(+)"

inherit check-reqs chromium-2 desktop flag-o-matic llvm-r1 multiprocessing ninja-utils pax-utils
inherit python-any-r1 readme.gentoo-r1 systemd toolchain-funcs xdg-utils

# Use following environment variables to customise the build
# EXTRA_GN — pass extra options to gn
# NINJAOPTS="-k0 -j8" useful to populate ccache even if ebuild is still failing
# UGC_SKIP_PATCHES — space-separated list of patches to skip
# UGC_KEEP_BINARIES — space-separated list of binaries to keep
# UGC_SKIP_SUBSTITUTION — space-separated list of files to skip domain substitution

UGC_SKIP_PATCHES="
	core/ungoogled-chromium/disable-privacy-sandbox.patch \
	core/ungoogled-chromium/fix-building-without-safebrowsing.patch \
	extra/debian/disable/google-api-warning.patch \
	extra/inox-patchset/0013-disable-missing-key-warning.patch \
	extra/inox-patchset/0016-chromium-sandbox-pie.patch \
	extra/ungoogled-chromium/fix-distilled-icons.patch \
	extra/ungoogled-chromium/enable-menu-on-reload-button.patch \
	extra/ungoogled-chromium/enable-default-prefetch-privacy-changes.patch \
	extra/ungoogled-chromium/add-flag-to-disable-local-history-expiration.patch \
	extra/ungoogled-chromium/add-flag-to-scroll-tabs.patch \
	extra/ungoogled-chromium/enable-page-saving-on-more-pages.patch \
	extra/ungoogled-chromium/add-flag-for-custom-ntp.patch \
	extra/ungoogled-chromium/add-flag-to-show-avatar-button.patch \
	extra/ungoogled-chromium/keep-expired-flags.patch \
	extra/ungoogled-chromium/disable-download-quarantine.patch \
	bromite/disable-fetching-field-trials.patch \
	extra/ungoogled-chromium/add-flag-for-tab-hover-cards.patch \
	extra/ungoogled-chromium/add-flag-for-close-confirmation.patch \
	extra/ungoogled-chromium/add-flag-to-close-window-with-last-tab.patch \
	upstream-fixes/hardware_destructive_interference_size.patch \
	extra/inox-patchset/0008-restore-classic-ntp.patch \
	extra/iridium-browser/net-cert-increase-default-key-length-for-newly-gener.patch \
	extra/ungoogled-chromium/add-flag-for-tabsearch-button.patch
"

DESCRIPTION="Chromium fork focused on high performance and security"
HOMEPAGE="https://thorium.rocks"
PPC64_HASH="a85b64f07b489b8c6fdb13ecf79c16c56c560fc6"
PATCH_V="${PV%%\.*}-2"
THORIUM_COMMIT_ID="6a89d88a334d8df585ce07f9a56254ef85fc8956"
THORIUM_WD="${WORKDIR}/thorium-${THORIUM_COMMIT_ID}"
UGC_PVR="130.0.6723.116-1"
UGC_PF="ungoogled-chromium-${UGC_PVR}"
UGC_WD="${WORKDIR}/${UGC_PF}"
T_LIBJXL_COMMIT_ID="059d2253e91e3c8af7cc860f1c633f18ac19eb67"
T_LIBJXL_PF="thorium-libjxl-${T_LIBJXL_COMMIT_ID}"
T_LIBJXL_WD="${WORKDIR}/${T_LIBJXL_PF}"
SRC_URI="https://github.com/blackteahamburger/gentoo-chromium-source-tarball/releases/download/${PV}/chromium-${PV}.tar.xz
	test? (
		https://github.com/blackteahamburger/gentoo-chromium-source-tarball/releases/download/${PV}/chromium-${PV}-testdata.tar.xz -> chromium-${PV}-testdata-gentoo.tar.xz
		https://chromium-fonts.storage.googleapis.com/${TEST_FONT} -> chromium-testfonts-${TEST_FONT:0:10}.tar.gz
	)
	https://github.com/Alex313031/thorium/archive/${THORIUM_COMMIT_ID}.tar.gz -> thorium-${THORIUM_COMMIT_ID}.tar.gz
	https://gitlab.com/Matt.Jolly/chromium-patches/-/archive/${PATCH_V}/chromium-patches-${PATCH_V}.tar.bz2
	ppc64? (
		https://gitlab.raptorengineering.com/raptor-engineering-public/chromium/openpower-patches/-/archive/${PPC64_HASH}/openpower-patches-${PPC64_HASH}.tar.bz2 -> chromium-openpower-${PPC64_HASH:0:10}.tar.bz2
	)
	ungoogled? ( https://github.com/ungoogled-software/ungoogled-chromium/archive/${UGC_PVR}.tar.gz -> ${UGC_PF}.tar.gz )
	thorium-libjxl? ( https://github.com/Alex313031/thorium-libjxl/archive/${T_LIBJXL_COMMIT_ID}.tar.gz -> ${T_LIBJXL_PF}.tar.gz )
	thorium-shell? ( https://chromium-fonts.storage.googleapis.com/${TEST_FONT} -> chromium-testfonts-${TEST_FONT:0:10}.tar.gz )
"

declare -A CHROMIUM_COMMITS=(
	["587c2cf8b11d3c32fa26887063eda3171a3d353e"]="third_party/ruy/src"
	["dc9db222b929f5da415216134b77d7f3bf141813"]="." #131+
	["7e28832cd3320d2b603e6ef9468581e1c65c14f1"]="." #131+
	["b51da416e04ecc9edafff531f9678c6404e654b7"]="." #131+
	["4c49d7f04f43ab4757637cac21cfef7c0cd060fc"]="." #131+
	["47fb59539e5744467eb6f7aae52f5a169910d56c"]="." #131+
	["39583ff118920284de516d262979960e7159bcfc"]="." #131+
	["c502d310d8cb91f1c1098a7287e75114023e57f0"]="." #131+
	["40c273b2c0f5f26e16e67428ceaafd8b339bb61f"]="." #131+
	["8739a5b33176e82e06a746163c0c76de4908ced9"]="." #131+
)

if [ ! -z "${CHROMIUM_COMMITS[*]}" ]; then
	for i in "${!CHROMIUM_COMMITS[@]}"; do
		if [[ ${CHROMIUM_COMMITS[$i]} =~ webrtc ]]; then
		#TODO: is it safe to use this mirror?
		SRC_URI+="https://github.com/webrtc-mirror/webrtc/commit/${i/-}.patch?full_index=true -> webrtc-${i/-}.patch
		"
		elif [[ ${CHROMIUM_COMMITS[$i]} =~ angle ]]; then
		SRC_URI+="https://github.com/google/angle/commit/${i/-}.patch?full_index=true -> angle-${i/-}.patch
		"
		elif [[ ${CHROMIUM_COMMITS[$i]} =~ quiche ]]; then
		SRC_URI+="https://github.com/google/quiche/commit/${i/-}.patch?full_index=true -> quiche-${i/-}.patch
		"
		elif [[ ${CHROMIUM_COMMITS[$i]} =~ vulkan-utility-libraries ]]; then
		SRC_URI+="https://github.com/KhronosGroup/Vulkan-Utility-Libraries/commit/${i/-}.patch?full_index=true -> vulkan-utility-libraries-${i/-}.patch
		"
		elif [[ ${CHROMIUM_COMMITS[$i]} =~ ruy ]]; then
		SRC_URI+="https://github.com/google/ruy/commit/${i/-}.patch?full_index=true -> ruy-${i/-}.patch
		"
		else
		SRC_URI+="https://github.com/chromium/chromium/commit/${i/-}.patch?full_index=true -> chromium-${i/-}.patch
		"
		fi
	done
fi

S="${WORKDIR}/chromium-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE_SYSTEM_LIBS="av1 brotli crc32c double-conversion ffmpeg +harfbuzz +icu jsoncpp +libevent +libusb libvpx +openh264 openjpeg +png re2 snappy woff2 +zstd"
IUSE="+X bluetooth cfi convert-dict cups cpu_flags_arm_neon custom-cflags debug enable-driver gtk4 hangouts headless hevc kerberos lto libcxx nvidia +official +optimize-webui pax-kernel +pgo +proprietary-codecs pulseaudio qt6 screencast selinux test ungoogled vaapi wayland widevine cpu_flags_ppc_vsx3"

for i in ${IUSE_SYSTEM_LIBS}; do
	[[ $i =~ ^(\+)?(.*)$ ]]
	IUSE+=" ${BASH_REMATCH[1]}system-${BASH_REMATCH[2]}"
done

# Thorium specific
IUSE+=" cpu_flags_x86_avx512f cpu_flags_x86_avx2 cpu_flags_x86_sse4_1 cpu_flags_x86_sse3 cpu_flags_x86_sse2 +thorium-libjxl thorium-shell"

RESTRICT="
	!system-ffmpeg? ( proprietary-codecs? ( bindist ) )
	!system-openh264? ( bindist )
	!test? ( test )
"
REQUIRED_USE="
	x86? ( !widevine )
	debug? ( !official )
	ppc64? ( !cfi )
	test? ( cfi )
	screencast? ( wayland )
	!headless? ( || ( X wayland ) )
	!proprietary-codecs? ( !hevc )
	vaapi? ( !system-av1 !system-libvpx )
"

COMMON_X_DEPEND="
	x11-libs/libXcomposite:=
	x11-libs/libXcursor:=
	x11-libs/libXdamage:=
	x11-libs/libXfixes:=
	>=x11-libs/libXi-1.6.0:=
	x11-libs/libXrandr:=
	x11-libs/libXrender:=
	x11-libs/libXtst:=
	x11-libs/libxshmfence:=
"

COMMON_SNAPSHOT_DEPEND="
	system-brotli? ( >=app-arch/brotli-9999 )
	system-crc32c? ( dev-libs/crc32c )
	system-double-conversion? ( dev-libs/double-conversion )
	system-woff2? ( media-libs/woff2 )
	system-snappy? ( app-arch/snappy )
	system-jsoncpp? ( dev-libs/jsoncpp )
	system-libevent? ( dev-libs/libevent )
	thorium-libjxl? ( media-libs/libjxl )
	system-openjpeg? ( media-libs/openjpeg:2= )
	system-re2? ( >=dev-libs/re2-0.2019.08.01:= )
	system-libvpx? ( >=media-libs/libvpx-1.13.0:=[postproc] )
	system-libusb? ( virtual/libusb:1 )
	system-icu? ( >=dev-libs/icu-73.0:= )
	>=dev-libs/libxml2-2.12.4:=[icu]
	dev-libs/nspr:=
	>=dev-libs/nss-3.26:=
	dev-libs/libxslt:=
	media-libs/fontconfig:=
	>=media-libs/freetype-2.11.0-r1:=
	system-harfbuzz? ( >=media-libs/harfbuzz-3:0=[icu(-)] )
	media-libs/libjpeg-turbo:=
	system-png? ( media-libs/libpng:=[-apng(-)] )
	system-zstd? ( >=app-arch/zstd-1.5.5:= )
	>=media-libs/libwebp-0.4.0:=
	media-libs/mesa:=[gbm(+)]
	>=media-libs/openh264-1.6.0:=
	system-av1? (
		>=media-libs/dav1d-1.0.0:=
		>=media-libs/libaom-3.7.0:=
	)
	sys-libs/zlib:=
	x11-libs/libdrm:=
	sys-libs/zlib:=
	x11-libs/libdrm:=
	!headless? (
		dev-libs/glib:2
		>=media-libs/alsa-lib-1.0.19:=
		pulseaudio? (
			|| (
				media-libs/libpulse
				>=media-sound/apulse-0.1.9
			)
		)
		sys-apps/pciutils:=
		kerberos? ( virtual/krb5 )
		vaapi? ( >=media-libs/libva-2.7:=[X?,wayland?] )
		X? (
			x11-base/xorg-proto:=
			x11-libs/libX11:=
			x11-libs/libxcb:=
			x11-libs/libXext:=
		)
		x11-libs/libxkbcommon:=
		wayland? (
			dev-libs/libffi:=
			dev-libs/wayland:=
			screencast? (
				media-video/pipewire:=
				|| (
					sys-apps/xdg-desktop-portal-gnome
					sys-apps/xdg-desktop-portal-gtk
					kde-plasma/xdg-desktop-portal-kde
					gui-libs/xdg-desktop-portal-lxqt
					gui-libs/xdg-desktop-portal-wlr
				)
			)
		)
	)
"

COMMON_DEPEND="
	${COMMON_SNAPSHOT_DEPEND}
	app-arch/bzip2:=
	dev-libs/expat:=
	system-ffmpeg? (
		>=media-video/ffmpeg-4.3:=
		|| (
			media-video/ffmpeg[-samba]
			>=net-fs/samba-4.5.10-r1[-debug(-)]
		)
		>=media-libs/opus-1.3.1:=
	)
	net-misc/curl[ssl]
	sys-apps/dbus:=
	media-libs/flac:=
	sys-libs/zlib:=[minizip]
	!headless? (
		X? ( ${COMMON_X_DEPEND} )
		>=app-accessibility/at-spi2-core-2.46.0:2
		media-libs/mesa:=[X?,wayland?]
		cups? ( >=net-print/cups-1.3.11:= )
		virtual/udev
		x11-libs/cairo:=
		x11-libs/gdk-pixbuf:2
		x11-libs/pango:=
		qt6? ( dev-qt/qtbase:6[gui,widgets] )
	)
"

RDEPEND="${COMMON_DEPEND}
	!headless? (
		|| (
			x11-libs/gtk+:3[X?,wayland?]
			gui-libs/gtk:4[X?,wayland?]
		)
		qt6? ( dev-qt/qtbase:6[X?,wayland?] )
	)
	virtual/ttf-fonts
	selinux? ( sec-policy/selinux-chromium )
"

DEPEND="${COMMON_DEPEND}
	!headless? (
		gtk4? ( gui-libs/gtk:4[X?,wayland?] )
		!gtk4? ( x11-libs/gtk+:3[X?,wayland?] )
	)
"

BDEPEND="
	${COMMON_SNAPSHOT_DEPEND}
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
	')
	>=app-arch/gzip-1.7
	!headless? (
		qt6? ( dev-qt/qtbase:6 )
	)
	$(llvm_gen_dep '
		llvm-core/llvm:${LLVM_SLOT}
		!pgo? (
			llvm-core/clang:${LLVM_SLOT}
			|| ( llvm-core/lld:${LLVM_SLOT} sys-devel/mold )
		)
		pgo? (
			>llvm-core/clang-19.0.0_pre20240518:${LLVM_SLOT}
			|| ( >llvm-core/lld-19.0.0_pre20240518:${LLVM_SLOT} sys-devel/mold )
		)
		cfi? ( llvm-runtimes/compiler-rt-sanitizers:${LLVM_SLOT}[cfi] )
	')
	>=dev-build/gn-${GN_MIN_VER}
	app-alternatives/ninja
	dev-lang/perl
	>=dev-util/gperf-3.2
	dev-vcs/git
	>=net-libs/nodejs-7.6.0[inspector]
	>=sys-devel/bison-2.4.3
	sys-devel/flex
	virtual/pkgconfig
"

if ! has chromium_pkg_die ${EBUILD_DEATH_HOOKS}; then
	EBUILD_DEATH_HOOKS+=" chromium_pkg_die";
fi

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="
Some web pages may require additional fonts to display properly.
Try installing some of the following packages if some characters
are not displayed properly:
- media-fonts/arphicfonts
- media-fonts/droid
- media-fonts/ipamonafont
- media-fonts/noto
- media-fonts/ja-ipafonts
- media-fonts/takao-fonts
- media-fonts/wqy-microhei
- media-fonts/wqy-zenhei

To fix broken icons on the Downloads page, you should install an icon
theme that covers the appropriate MIME types, and configure this as your
GTK+ icon theme.

For native file dialogs in KDE, install kde-apps/kdialog.

To make password storage work with your desktop environment you may
have install one of the supported credentials management applications:
- app-crypt/libsecret (GNOME)
- kde-frameworks/kwallet (KDE)
If you have one of above packages installed, but don't want to use
them in Chromium, then add --password-store=basic to CHROMIUM_FLAGS
in /etc/thorium/default.
"

python_check_deps() {
	python_has_version "dev-python/setuptools[${PYTHON_USEDEP}]"
}

pre_build_checks() {
	# Check build requirements: bugs #471810, #541816, #914220
	# We're going to start doing maths here on the size of an unpacked source tarball,
	# this should make updates easier as chromium continues to balloon in size.
	local BASE_DISK=24
	local EXTRA_DISK=1
	local CHECKREQS_MEMORY="4G"
	tc-is-cross-compiler && EXTRA_DISK=2
	# Bug #952923
	#if tc-is-lto || use pgo; then
	if use lto || use pgo; then
		CHECKREQS_MEMORY="9G"
		tc-is-cross-compiler && EXTRA_DISK=4
		use pgo && EXTRA_DISK=8
	fi
	if is-flagq '-g?(gdb)?([1-9])'; then
		if use custom-cflags; then
			EXTRA_DISK=13
		fi
		CHECKREQS_MEMORY="16G"
	fi
	CHECKREQS_DISK_BUILD="$((BASE_DISK + EXTRA_DISK))G"
	check-reqs_${EBUILD_PHASE_FUNC}
}

pkg_pretend() {
	if use libcxx; then
		ewarn
		ewarn "Building with libcxx, please be aware that system-*"
		ewarn "and some other c++ dependencies need to be compiled"
		ewarn "with the same c++ library as thorium itself"
		ewarn "dev-libs/jsoncpp is most problematic, see #58 #49 #119 for details"
		ewarn "Simplest solution would be to disable corresponding system-* flags"
		ewarn
	fi
	if use cfi; then
		ewarn
		ewarn "Building with cfi is only possible if building with -stdlib=libc++"
		ewarn "Make sure all dependencies are also built this way, see #40"
		ewarn
	fi
	pre_build_checks

	if use headless; then
		local headless_unused_flags=("cups" "kerberos" "pulseaudio" "qt6" "vaapi" "wayland")
		for myiuse in ${headless_unused_flags[@]}; do
			use ${myiuse} && ewarn "Ignoring USE=${myiuse}, USE=headless is set."
		done
	fi
}

pkg_setup() {
	pre_build_checks

	# The linux:unbundle toolchain in GN grabs CC, CXX, CPP (etc) from the environment
	# We'll set these to clang here then use llvm-utils functions to very explicitly set these
	# to a sane value.
	# This is effectively the 'force-clang' path if GCC support is re-added.
	# TODO: check if the user has already selected a specific impl via make.conf and respect that.
	use_lto="false"
	# Bug #952923
	#if tc-is-lto; then
	if use lto; then
		if ! use x86; then
			use_lto="true"
		fi
		# We can rely on GN to do this for us; anecdotally without this builds
		# take significantly longer with LTO enabled and it doesn't hurt anything.
		filter-lto
	fi

	if [ "$use_lto" = "false" ] && use official; then
		einfo "USE=official selected and LTO not detected."
		einfo "It is _highly_ recommended that LTO be enabled for performance reasons"
		einfo "and to be consistent with the upstream \"official\" build optimisations."
	fi

	if [ "$use_lto" = "false" ] && use cfi; then
		die "CFI requires LTO"
	fi

	export use_lto

	llvm-r1_pkg_setup

	# Forcing clang; respect llvm_slot_x to enable selection of impl from LLVM_COMPAT
	AR=llvm-ar
	CPP="${CHOST}-clang++-${LLVM_SLOT} -E"
	NM=llvm-nm
	CC="${CHOST}-clang-${LLVM_SLOT}"
	CXX="${CHOST}-clang++-${LLVM_SLOT}"
	if tc-is-cross-compiler; then
		CPP="${CBUILD}-clang++-${LLVM_SLOT} -E"
	fi

	# Users should never hit this, it's purely a development convenience
	if ver_test $(gn --version || die) -lt ${GN_MIN_VER}; then
		die "dev-build/gn >= ${GN_MIN_VER} is required to build this Chromium"
	fi

	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	unpack chromium-${PV}.tar.xz
	unpack chromium-patches-${PATCH_V}.tar.bz2

	if use test; then
		# A new testdata tarball is available for each release; but testfonts tend to remain stable
		# for the duration of a release.
		# This unpacks directly into/over ${S} so we can just use `unpack`.
		unpack chromium-${PV}-testdata-gentoo.tar.xz
	fi

	if use test; then
		# This just contains a bunch of font files that need to be unpacked (or moved) to the correct location.
		local testfonts_dir="${S}/third_party/test_fonts"
		local testfonts_tar="${DISTDIR}/chromium-testfonts-${TEST_FONT:0:10}.tar.gz"
		tar xf "${testfonts_tar}" -C "${testfonts_dir}" || die "Failed to unpack testfonts"
	fi

	if use thorium-shell; then
		local testfonts_dir="${S}/third_party/test_fonts/test_fonts"
		local testfonts_tar="${DISTDIR}/chromium-testfonts-${TEST_FONT:0:10}.tar.gz"
		tar xf "${testfonts_tar}" -C "${testfonts_dir}" || die "Failed to unpack testfonts"
	fi

	unpack thorium-${THORIUM_COMMIT_ID}.tar.gz

	use ungoogled && unpack ${UGC_PF}.tar.gz

	if use ppc64; then
		unpack chromium-openpower-${PPC64_HASH:0:10}.tar.bz2
	fi

	if use thorium-libjxl; then
		unpack ${T_LIBJXL_PF}.tar.gz
	fi
}

src_prepare() {
	# Calling this here supports resumption via FEATURES=keepwork
	python_setup

	einfo "Applying Thorium patches"
	if use thorium-libjxl; then
		sed -i "s|cp -r -v thorium-libjxl|cp -r -v ${T_LIBJXL_WD}|" "${THORIUM_WD}/setup.sh" || die
	else
		sed -i '/thorium-libjxl/d' "${THORIUM_WD}/setup.sh" || die
	fi
	if ! use thorium-shell; then
		sed -i '/thorium_shell/d' "${THORIUM_WD}/setup.sh" || die
	fi
	sed -i "s|cd ~/thorium|cd ${THORIUM_WD}|" "${THORIUM_WD}/setup.sh" || die
	sed -i '/update_pgo_profiles.py/d' "${THORIUM_WD}/setup.sh" || die
	local setup_arg
	if use cpu_flags_x86_avx512f; then
		setup_arg="--avx512"
	elif use cpu_flags_x86_avx2; then
		setup_arg="--avx2"
	elif use cpu_flags_x86_sse4_1; then
		setup_arg="--sse4"
	elif use cpu_flags_x86_sse3; then
		setup_arg="--sse3"
	elif use cpu_flags_x86_sse2; then
		setup_arg="--sse2"
	else
		setup_arg=""
	fi
	CR_DIR="${S}" "${THORIUM_WD}/setup.sh" ${setup_arg} || die
	if [[ -z ${setup_arg} ]]; then
		sed -i "s|other/ffmpeg_hevc_ac3.patch|${THORIUM_WD}/other/ffmpeg_hevc_ac3.patch|" "${THORIUM_WD}/patch_ac3.sh" || die
		CR_DIR="${S}" "${THORIUM_WD}/patch_ac3.sh" || die
	fi

	rm "${WORKDIR}/chromium-patches-${PATCH_V}/chromium-131-compiler.patch" || die
	if ! use custom-cflags; then #See #25 #92
		sed -i '/default_stack_frames/Q' "${FILESDIR}/chromium-131-compiler.patch" || die
	fi

	# disable global media controls, crashes with libstdc++
	sed -i -e \
		"/\"GlobalMediaControlsCastStartStop\"/,+4{s/ENABLED/DISABLED/;}" \
		"chrome/browser/media/router/media_router_feature.cc"

	local PATCHES=(
		"${FILESDIR}/chromium-cross-compile.patch"
		"${FILESDIR}/chromium-109-system-openh264.patch"
		"${FILESDIR}/chromium-109-system-zlib.patch"
		"${FILESDIR}/chromium-111-InkDropHost-crash.patch"
		"${FILESDIR}/chromium-126-oauth2-client-switches.patch"
		"${FILESDIR}/chromium-125-cloud_authenticator.patch"
		"${FILESDIR}/chromium-123-qrcode.patch"
		"${FILESDIR}/perfetto-system-zlib.patch"
		"${FILESDIR}/chromium-127-cargo_crate.patch"
		"${FILESDIR}/chromium-127-crabby.patch"
		"${FILESDIR}/chromium-128-gtk-fix-prefers-color-scheme-query.patch"
		"${FILESDIR}/chromium-130-fontations.patch"
		"${FILESDIR}/chromium-132-no-link-builtins.patch"
		"${FILESDIR}/chromium-132-mold.patch"
		"${FILESDIR}/chromium-134-qt5-optional.patch"
		"${FILESDIR}/chromium-131-compiler.patch"
		"${FILESDIR}/chromium-130-fix-includes.patch" # https://github.com/Alex313031/thorium/issues/978
		"${FILESDIR}/chromium-130-fix-building-without-tflite-lib.patch" # https://github.com/Alex313031/thorium/issues/978
		"${FILESDIR}/chromium-135-gperf.patch"
		"${FILESDIR}/chromium-137-fix-for-kde.patch"
	)

	shopt -s globstar nullglob
	# 130: moved the PPC64 patches into the chromium-patches repo
	local patch
	for patch in "${WORKDIR}/chromium-patches-${PATCH_V}"/**/*.patch; do
		if [[ ${patch} == *"ppc64le"* ]]; then
			use ppc64 && PATCHES+=( "${patch}" )
		else
			PATCHES+=( "${patch}" )
		fi
	done

	# We can't use the bundled compiler builtins with the system toolchain
	# `grep` is a development convenience to ensure we fail early when google changes something.
	local builtins_match="if (is_clang && !is_nacl && !is_cronet_build) {"
	grep -q "${builtins_match}" build/config/compiler/BUILD.gn || die "Failed to disable bundled compiler builtins"
	sed -i -e "/${builtins_match}/,+2d" build/config/compiler/BUILD.gn

	if use ppc64; then
		# Above this level there are ungoogled-chromium patches that we can't apply
		local patchset_dir="${WORKDIR}/openpower-patches-${PPC64_HASH}/patches/ppc64le"
		# Apply the OpenPOWER patches
		local power9_patch="patches/ppc64le/core/baseline-isa-3-0.patch"
		for patch in ${patchset_dir}/**/*.{patch,diff}; do
			if [[ ${patch} == *"${power9_patch}" ]]; then
				use cpu_flags_ppc_vsx3 && PATCHES+=( "${patch}" )
			else
				PATCHES+=( "${patch}" )
			fi
		done

		PATCHES+=( "${WORKDIR}/openpower-patches-${PPC64_HASH}/patches/upstream/blink-fix-size-assertions.patch" )
	fi

	shopt -u globstar nullglob

	ewarn
	ewarn "Following features are disabled:"
	ewarn " - Fontations Rust font stack"
	ewarn " - Crabby Avif parser/decoder implementation in Rust"
	ewarn

	if ! use libcxx ; then
		PATCHES+=(
			"${FILESDIR}/chromium-130-libstdc++.patch"
			"${FILESDIR}/font-gc-r2.patch"
		)
	fi

	if [ ! -z "${CHROMIUM_COMMITS[*]}" ]; then
		for i in "${!CHROMIUM_COMMITS[@]}"; do
			if [[ ${CHROMIUM_COMMITS[$i]} =~ webrtc ]]; then
				patch_prefix="webrtc"
			elif [[ ${CHROMIUM_COMMITS[$i]} =~ angle ]]; then
				patch_prefix="angle"
			elif [[ ${CHROMIUM_COMMITS[$i]} =~ quiche ]]; then
				patch_prefix="quiche"
			elif [[ ${CHROMIUM_COMMITS[$i]} =~ vulkan-utility-libraries ]]; then
				patch_prefix="vulkan-utility-libraries"
			elif [[ ${CHROMIUM_COMMITS[$i]} =~ ruy ]]; then
				patch_prefix="ruy"
			else
				patch_prefix="chromium"
			fi
			pushd "${CHROMIUM_COMMITS[$i]}" > /dev/null || die
			if [[ $i = -*  ]]; then
				einfo "Reverting ${patch_prefix}-${i/-}.patch"
				git apply -R --exclude="*unittest.cc" --exclude="DEPS" \
					-p1 < "${DISTDIR}/${patch_prefix}-${i/-}.patch" || die
			else
				einfo "Applying ${patch_prefix}-${i/-}.patch"
				git apply --exclude="*unittest.cc" --exclude="DEPS" \
					-p1 < "${DISTDIR}/${patch_prefix}-${i/-}.patch" || die
			fi
			popd > /dev/null || die
		done
	fi

	einfo "Reverting chromium-84fcdd0620a72aa73ea521c682fb246067f2c14d.patch"
	eapply "${FILESDIR}/chromium-revert-84fcdd0620a72aa73ea521c682fb246067f2c14d.patch"

	einfo "Applying perfetto-acc24608c84d2d2d8d684f40a110d0a6f4eddc51.patch"
	pushd third_party/perfetto
	eapply "${FILESDIR}/perfetto-acc24608c84d2d2d8d684f40a110d0a6f4eddc51.patch"
	popd

	if ! use bluetooth ; then
		PATCHES+=(
			"${FILESDIR}/disable-bluez-r1.patch"
		)
	fi

	if use convert-dict ; then
		PATCHES+=(
			"${FILESDIR}/chromium-ucf-dict-utility-r1.patch"
		)
	fi

	if use system-ffmpeg; then
		PATCHES+=(
			"${FILESDIR}/chromium-99-opus.patch"
		)
		if has_version "<media-video/ffmpeg-5.0"; then
			PATCHES+=(
				"${FILESDIR}/chromium-118-ffmpeg.patch"
				"${FILESDIR}/unbundle-ffmpeg-av_stream_get_first_dts.patch"
			)
		else
			ewarn "You need to expose \"av_stream_get_first_dts\" in ffmpeg via user patch"
		fi
		if has_version "<media-video/ffmpeg-6.0"; then
			PATCHES+=(
				"${FILESDIR}/reverse-roll-src-third_party-ffmpeg.patch"
				"${FILESDIR}/reverse-roll-src-third_party-ffmpeg_duration.patch"
			)
		fi
		if has_version "<media-video/ffmpeg-6.1"; then
			eapply -R "${FILESDIR}/ffmpeg-nb_coded_side_data-dolby.diff"
			eapply -R "${FILESDIR}/ffmpeg-nb_coded_side_data-r1.patch"
		fi
	fi

	if use system-av1; then
		PATCHES+=(
			"${FILESDIR}/chromium-system-av1.patch"
		)
	fi

	if use system-libvpx; then
		PATCHES+=(
			"${FILESDIR}/chromium-system-libvpx.patch"
		)
	fi

	if use system-openjpeg ; then
		PATCHES+=(
			"${FILESDIR}/chromium-system-openjpeg-r4.patch"
		)
	fi

	if ! use thorium-libjxl; then
		PATCHES+=(
			"${FILESDIR}/thorium-130-fix-building-without-libjxl.patch"
		)
	fi

	default

	mkdir -p third_party/node/linux/node-linux-x64/bin || die
	ln -s "${EPREFIX}"/usr/bin/node third_party/node/linux/node-linux-x64/bin/node || die

	# adjust python interpreter version
	sed -i -e "s|\(^script_executable = \).*|\1\"${EPYTHON}\"|g" .gn || die

	cp "${FILESDIR}/libusb.gn" build/linux/unbundle || die
	sed -i '/^REPLACEMENTS.*$/{s++REPLACEMENTS = {"libusb":"third_party/libusb/BUILD.gn",+;h};${x;/./{x;q0};x;q1}' \
		build/linux/unbundle/replace_gn_files.py || die
	sed -i '/^.*deps.*third_party\/jsoncpp.*$/{s++public_deps \+= [ "//third_party/jsoncpp" ]+;h};${x;/./{x;q0};x;q1}' \
		third_party/webrtc/rtc_base/BUILD.gn || die

	if use hevc; then
		sed -i '/^bool IsHevcProfileSupported(const VideoType& type) {$/{s++bool IsHevcProfileSupported(const VideoType\& type) { return true;+;h};${x;/./{x;q0};x;q1}' \
			media/base/supported_types.cc || die
	fi

	if use ungoogled; then
		# From here we adapt ungoogled-chromium's patches to our needs
		local ugc_pruning_list="${UGC_WD}/pruning.list"
		local ugc_patch_series="${UGC_WD}/patches/series"
		local ugc_substitution_list="${UGC_WD}/domain_substitution.list"

		sed -i '11,40d' \
			"${UGC_WD}/patches/upstream-fixes/missing-dependencies.patch" || die
		sed -i '/^---.*minidump_uploader.cc/,+10d' \
			"${UGC_WD}/patches/core/iridium-browser/all-add-trk-prefixes-to-possibly-evil-connections.patch" || die
		sed -i '/aw_browser_context.cc/,+16d' \
			"${UGC_WD}/patches/core/ungoogled-chromium/remove-unused-preferences-fields.patch" || die
		sed -i 's/net::SecureDnsMode::kAutomatic/net::SecureDnsMode::kSecure/' \
			"${UGC_WD}/patches/core/ungoogled-chromium/doh-changes.patch" || die
		sed -i '683,714d;880,889d;656,674d' \
			"${UGC_WD}/patches/core/ungoogled-chromium/fix-building-with-prunned-binaries.patch" || die
		sed -i '4,5d' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-ungoogled-flag-headers.patch" || die
		sed -i '4a \ // Include Thorium Flags\
 \#include "chrome/browser/thorium_flag_choices.h"' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-ungoogled-flag-headers.patch" || die
		sed -i '2,12d;24,34d;99,109d' \
			"${UGC_WD}/patches/extra/inox-patchset/0006-modify-default-prefs.patch" || die
		sed -i -e 's/kExpandHoverDelayMS = 1600/kExpandHoverDelayMS = 1/' \
			-e '14,22d' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/disable-formatting-in-omnibox.patch" || die
		sed -i '19,21c \      "Force punycode hostnames",\
      "Force punycode in hostnames instead of Unicode when displaying Internationalized Domain Names (IDNs). ungoogled-chromium flag.",\
      kOsAll, SINGLE_VALUE_TYPE("force-punycode-hostnames")},' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-to-hide-crashed-bubble.patch" || die
		sed -i '1,15d' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/enable-paste-and-go-new-tab-button.patch" || die
		sed -i "41,43c \      \"Hide crashed bubble\",\n\
      \"Hides the bubble box with the message \\\"Restore Pages? Chromium didn't shut down correctly.\\\" that shows on startup after the browser did not exit cleanly. ungoogled-chromium flag.\",\n\
      kOsAll, SINGLE_VALUE_TYPE(\"hide-crashed-bubble\")}," \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-for-bookmark-bar-ntp.patch" || die
		sed -i -e '6,8c \      "Force punycode hostnames",\
      "Force punycode in hostnames instead of Unicode when displaying Internationalized Domain Names (IDNs). ungoogled-chromium flag.",\
      kOsAll, SINGLE_VALUE_TYPE("force-punycode-hostnames")},' \
			-e '13c \     {"hide-crashed-bubble",' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-to-convert-popups-to-tabs.patch" || die
		sed -i -e '78,80c \      "Force punycode hostnames",\
      "Force punycode in hostnames instead of Unicode when displaying Internationalized Domain Names (IDNs). ungoogled-chromium flag.",\
      kOsAll, SINGLE_VALUE_TYPE("force-punycode-hostnames")},' \
			-e '85c \     {"popups-to-tabs",' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-to-clear-data-on-exit.patch" || die
		sed -i '23,25c \      "Omnibox Autocomplete Filtering",\
      "Restrict omnibox autocomplete results to a combination of search suggestions (if enabled), bookmarks, and internal chrome pages. ungoogled-chromium flag.",\
      kOsAll, MULTI_VALUE_TYPE(kOmniboxAutocompleteFiltering)},' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-for-qr-generator.patch" || die
		sed -i '27,29c \      "Remove Grab Handle",\
      "Removes the reserved empty space in the tabstrip for moving the window. ungoogled-chromium flag.",\
      kOsDesktop, SINGLE_VALUE_TYPE("remove-grab-handle")},' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-to-hide-tab-close-buttons.patch" || die
		sed -i 's/base::FEATURE_ENABLED_BY_DEFAULT/fix_borked_macos_build/' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/disable-remote-optimization-guide.patch" || die
		sed -i -e '15,17c \            ? new_value\
            : existing_value;\
   }' \
			-e '23,25c \   const std::string new_value =\
       internal_name == "custom-ntp"\
           ? value' \
			-e 's/internal_name == "http-accept-header" ? value :/: internal_name == "http-accept-header" ? value/' \
			-e 's/CombineAndSanitizeOriginLists(std::string(), value);/: CombineAndSanitizeOriginLists(std::string(), value);/' \
			-e '30,49d' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/add-flag-to-change-http-accept-header.patch" || die
		sed -i '17a \ \#include "chrome/browser/ui/webui/thorium_webui.h"' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/first-run-page.patch" || die
		sed -i '21d' "${UGC_WD}/patches/extra/ungoogled-chromium/first-run-page.patch" || die
		sed -i '176a \       kChromeUIEggsHost,' \
			"${UGC_WD}/patches/extra/ungoogled-chromium/first-run-page.patch" || die
		sed -i '180d' "${UGC_WD}/patches/extra/ungoogled-chromium/first-run-page.patch" || die

		UGC_SKIP_SUBSTITUTION="${UGC_SKIP_SUBSTITUTION} flag-metadata.json histograms.xml \
			chrome_file_system_access_permission_context.cc layer_tree_view.cc"

		if use thorium-shell; then
			sed -i '/third_party\/test_fonts\/test_fonts/d' \
				"${UGC_WD}/utils/prune_binaries.py" || die
		fi

		local ugc_unneeded=(
			# GN bootstrap
			extra/debian/gn/parallel
		)

		#* Didn't unpack them at the first place
		sed -i "\!build/linux/debian_bullseye_i386-sysroot!d" "${ugc_pruning_list}" || die
		sed -i "\!build/linux/debian_bullseye_amd64-sysroot!d" "${ugc_pruning_list}" || die
		sed -i "\!third_party/llvm-build!d" "${ugc_pruning_list}" || die
		sed -i "\!third_party/node/linux!d" "${ugc_pruning_list}" || die
		sed -i "\!third_party/rust-src!d" "${ugc_pruning_list}" || die
		sed -i "\!third_party/rust-toolchain!d" "${ugc_pruning_list}" || die
		if ! use libcxx ; then
			sed -i "\!third_party/libc!d" "${ugc_pruning_list}" || die
		fi
		sed -i "s|debug('Files|error('Files|" \
			"${UGC_WD}/utils/prune_binaries.py" || die
		sed -i "\!third_party/node/linux!d" \
			"${UGC_WD}/utils/prune_binaries.py" || die
		sed -i '/sys.exit(1)/d' "${UGC_WD}/utils/prune_binaries.py" || die

		local ugc_p ugc_dir
		for p in "${ugc_unneeded[@]}"; do
			einfo "Removing ${p}.patch"
			sed -i "\!${p}.patch!d" "${ugc_patch_series}" || die
		done

		if [ ! -z "${UGC_SKIP_PATCHES}" ]; then
		for p in ${UGC_SKIP_PATCHES}; do
			ewarn "Removing ${p}"
			sed -i "\!${p}!d" "${ugc_patch_series}" || die
		done
		fi

		if [ ! -z "${UGC_KEEP_BINARIES}" ]; then
		for p in ${UGC_KEEP_BINARIES}; do
			ewarn "Keeping binary ${p}"
			sed -i "\!${p}!d" "${ugc_pruning_list}" || die
		done
		fi

		if [ ! -z "${UGC_SKIP_SUBSTITUTION}" ]; then
		for p in ${UGC_SKIP_SUBSTITUTION}; do
			ewarn "No substitutions in ${p}"
			sed -i "\!${p}!d" "${ugc_substitution_list}" || die
		done
		fi

		ebegin "Pruning binaries"
		"${UGC_WD}/utils/prune_binaries.py" -q . "${UGC_WD}/pruning.list"
		eend $? || die

		ebegin "Applying ungoogled-chromium patches"
		"${UGC_WD}/utils/patches.py" -q apply . "${UGC_WD}/patches"
		eend $? || die
		eapply "${FILESDIR}/fix-building-without-safebrowsing.patch"

		ebegin "Applying domain substitution"
		"${UGC_WD}/utils/domain_substitution.py" -q apply -r "${UGC_WD}/domain_regex.list" -f "${UGC_WD}/domain_substitution.list" .
		eend $? || die
	fi

	# remove_bundled_libraries.py walks the source tree and looks for paths containing the substring 'third_party'
	# whitelist matches use the right-most matching path component, so we need to whitelist from that point down.
	local keeplibs=(
		base/third_party/cityhash
	)
	use system-double-conversion || keeplibs+=(
		base/third_party/double_conversion
	)
	keeplibs+=(
		base/third_party/icu
		base/third_party/nspr
		base/third_party/superfasthash
		base/third_party/symbolize
		base/third_party/xdg_user_dirs
		buildtools/third_party/libc++
		buildtools/third_party/libc++abi
		chrome/third_party/mozilla_security_manager
		net/third_party/mozilla_security_manager
		net/third_party/nss
		net/third_party/quic
		net/third_party/uri_template
		third_party/abseil-cpp/absl/base
		third_party/abseil-cpp
	)
	keeplibs+=(
		third_party/angle
		third_party/angle/src/common/third_party/xxhash
		third_party/angle/src/third_party/ceval
	)
	use nvidia || keeplibs+=(
		third_party/angle/src/third_party/libXNVCtrl
	)
	keeplibs+=(
		third_party/angle/src/third_party/volk
		third_party/anonymous_tokens
		third_party/apple_apsl
		third_party/axe-core
		third_party/bidimapper
		third_party/blink
		third_party/boringssl
		third_party/boringssl/src/third_party/fiat
		third_party/breakpad
		third_party/breakpad/breakpad/src/third_party/curl
	)
	use system-brotli || keeplibs+=(
		third_party/brotli
	)
	keeplibs+=(
		third_party/catapult
		third_party/catapult/common/py_vulcanize/third_party/rcssmin
		third_party/catapult/common/py_vulcanize/third_party/rjsmin
		third_party/catapult/third_party/beautifulsoup4-4.9.3
		third_party/catapult/third_party/html5lib-1.1
		third_party/catapult/third_party/polymer
		third_party/catapult/third_party/six
		third_party/catapult/tracing/third_party/d3
		third_party/catapult/tracing/third_party/gl-matrix
		third_party/catapult/tracing/third_party/jpeg-js
		third_party/catapult/tracing/third_party/jszip
		third_party/catapult/tracing/third_party/mannwhitneyu
		third_party/catapult/tracing/third_party/oboe
		third_party/catapult/tracing/third_party/pako
		third_party/ced
		third_party/cld_3
		third_party/closure_compiler
		third_party/content_analysis_sdk
		third_party/cpuinfo
		third_party/crabbyavif
		third_party/crashpad
		third_party/crashpad/crashpad/third_party/lss
		third_party/crashpad/crashpad/third_party/zlib
	)
	use system-crc32c || keeplibs+=(
		third_party/crc32c
	)
	keeplibs+=(
		third_party/cros_system_api
		third_party/d3
		third_party/dawn
		third_party/dawn/third_party/gn/webgpu-cts
		third_party/dawn/third_party/khronos
		third_party/depot_tools
		third_party/devscripts
		third_party/devtools-frontend
		third_party/devtools-frontend/src/front_end/third_party/acorn
		third_party/devtools-frontend/src/front_end/third_party/additional_readme_paths.json
		third_party/devtools-frontend/src/front_end/third_party/axe-core
		third_party/devtools-frontend/src/front_end/third_party/chromium
		third_party/devtools-frontend/src/front_end/third_party/codemirror
		third_party/devtools-frontend/src/front_end/third_party/csp_evaluator
		third_party/devtools-frontend/src/front_end/third_party/diff
		third_party/devtools-frontend/src/front_end/third_party/i18n
		third_party/devtools-frontend/src/front_end/third_party/intl-messageformat
		third_party/devtools-frontend/src/front_end/third_party/lighthouse
		third_party/devtools-frontend/src/front_end/third_party/lit
		third_party/devtools-frontend/src/front_end/third_party/lodash-isequal
		third_party/devtools-frontend/src/front_end/third_party/marked
		third_party/devtools-frontend/src/front_end/third_party/puppeteer
		third_party/devtools-frontend/src/front_end/third_party/puppeteer/package/lib/esm/third_party/mitt
		third_party/devtools-frontend/src/front_end/third_party/puppeteer/package/lib/esm/third_party/parsel-js
		third_party/devtools-frontend/src/front_end/third_party/puppeteer/package/lib/esm/third_party/rxjs
		third_party/devtools-frontend/src/front_end/third_party/puppeteer/third_party/mitt
		third_party/devtools-frontend/src/front_end/third_party/puppeteer/third_party/rxjs
		third_party/devtools-frontend/src/front_end/third_party/third-party-web
		third_party/devtools-frontend/src/front_end/third_party/vscode.web-custom-data
		third_party/devtools-frontend/src/front_end/third_party/wasmparser
		third_party/devtools-frontend/src/front_end/third_party/web-vitals
		third_party/devtools-frontend/src/third_party
		third_party/distributed_point_functions
		third_party/dom_distiller_js
		third_party/eigen3
		third_party/emoji-segmenter
		third_party/farmhash
		third_party/fast_float
		third_party/fdlibm
		third_party/fft2d
		third_party/flatbuffers
		third_party/fp16
		third_party/freetype
		third_party/fusejs
		third_party/fxdiv
		third_party/gemmlowp
		third_party/google_input_tools
		third_party/google_input_tools/third_party/closure_library
		third_party/google_input_tools/third_party/closure_library/third_party/closure
		third_party/googletest
		third_party/highway
		third_party/hunspell
		third_party/iccjpeg
		third_party/inspector_protocol
		third_party/ipcz
		third_party/jinja2
	)
	use system-jsoncpp || keeplibs+=(
		third_party/jsoncpp
	)
	keeplibs+=(
		third_party/jstemplate
		third_party/khronos
		third_party/lens_server_proto
		third_party/leveldatabase
		third_party/libaddressinput
		third_party/libavif
	)
	use system-libevent || keeplibs+=(
		third_party/libevent
	)
	keeplibs+=(
		third_party/libgav1
		third_party/libjingle
	)
	keeplibs+=(
		third_party/libphonenumber
		third_party/libsecret
		third_party/libsrtp
		third_party/libsync
		third_party/liburlpattern
	)
	use system-libusb || keeplibs+=(
		third_party/libusb
	)
	keeplibs+=(
		third_party/libva_protected_content
	)
	use system-libvpx || keeplibs+=(
		third_party/libvpx
		third_party/libvpx/source/libvpx/third_party/x86inc
	)
	keeplibs+=(
		third_party/libwebm
		third_party/libx11
		third_party/libxcb-keysyms
		third_party/libxml/chromium
		third_party/libyuv
		third_party/libzip
		third_party/lit
		third_party/lottie
		third_party/lss
		third_party/lzma_sdk
		third_party/mako
		third_party/markupsafe
		third_party/material_color_utilities
		third_party/mesa
		third_party/metrics_proto
		third_party/minigbm
		third_party/modp_b64
		third_party/nasm
		third_party/nearby
		third_party/neon_2_sse
		third_party/node
		third_party/omnibox_proto
		third_party/one_euro_filter
		third_party/openscreen
		third_party/openscreen/src/third_party/
		third_party/openscreen/src/third_party/tinycbor/src/src
		third_party/ots
		third_party/pdfium
		third_party/pdfium/third_party/agg23
		third_party/pdfium/third_party/bigint
		third_party/pdfium/third_party/freetype
		third_party/pdfium/third_party/lcms
	)
	use system-openjpeg || keeplibs+=(
		third_party/pdfium/third_party/libopenjpeg
	)
	keeplibs+=(
		third_party/pdfium/third_party/libtiff
		third_party/perfetto
		third_party/perfetto/protos/third_party/chromium
		third_party/perfetto/protos/third_party/simpleperf
		third_party/pffft
		third_party/ply
		third_party/polymer
		third_party/private_membership
		third_party/private-join-and-compute
		third_party/protobuf
		third_party/pthreadpool
		third_party/puffin
		third_party/pyjson5
		third_party/pyyaml
		third_party/qcms
		third_party/rapidhash
		third_party/rnnoise
		third_party/ruy
		third_party/s2cellid
		third_party/securemessage
		third_party/selenium-atoms
		third_party/sentencepiece
		third_party/sentencepiece/src/third_party/darts_clone
		third_party/shell-encryption
		third_party/simplejson
		third_party/six
		third_party/skia
		third_party/skia/include/third_party/vulkan
		third_party/skia/third_party/vulkan
		third_party/smhasher
	)
	use system-snappy || keeplibs+=(
		third_party/snappy
	)
	keeplibs+=(
		third_party/spirv-headers
		third_party/spirv-tools
		third_party/sqlite
		third_party/swiftshader
		third_party/swiftshader/third_party/astc-encoder
		third_party/swiftshader/third_party/llvm-subzero
		third_party/swiftshader/third_party/marl
		third_party/swiftshader/third_party/SPIRV-Headers/include/spirv
		third_party/swiftshader/third_party/SPIRV-Tools
		third_party/swiftshader/third_party/subzero
		third_party/tensorflow_models
		third_party/tensorflow-text
		third_party/tflite
		third_party/tflite/src/third_party/eigen3
		third_party/tflite/src/third_party/fft2d
		third_party/tflite/src/third_party/xla/third_party/tsl
		third_party/tflite/src/third_party/xla/xla/tsl/util
		third_party/tflite/src/third_party/xla/xla/tsl/framework
		third_party/ukey2
	)
	use ungoogled || keeplibs+=(
		third_party/unrar
	)
	keeplibs+=(
		third_party/utf
		third_party/vulkan
		third_party/wayland
		third_party/webdriver
		third_party/webgpu-cts
		third_party/webrtc
		third_party/webrtc/common_audio/third_party/ooura
		third_party/webrtc/common_audio/third_party/spl_sqrt_floor
		third_party/webrtc/modules/third_party/fft
		third_party/webrtc/modules/third_party/g711
		third_party/webrtc/modules/third_party/g722
		third_party/webrtc/rtc_base/third_party/base64
		third_party/webrtc/rtc_base/third_party/sigslot
		third_party/widevine
	)
	use system-woff2 || keeplibs+=(
		third_party/woff2
	)
	keeplibs+=(
		third_party/wuffs
		third_party/x11proto
		third_party/xcbproto
		third_party/xnnpack
		third_party/zlib/google
		third_party/zxcvbn-cpp
		url/third_party/mozilla
		v8/src/third_party/siphash
		v8/src/third_party/utf8-decoder
		v8/src/third_party/valgrind
		v8/third_party/glibc
		v8/third_party/inspector_protocol
		v8/third_party/v8

		# gyp -> gn leftovers
		third_party/speech-dispatcher
		third_party/usb_ids
		third_party/xdg-utils
	)

	if use test; then
		# tar tvf /var/cache/distfiles/${P}-testdata.tar.xz | grep '^d' | grep 'third_party' | awk '{print $NF}'
		keeplibs+=(
			third_party/google_benchmark/src/include/benchmark
			third_party/google_benchmark/src/src
			third_party/perfetto/protos/third_party/pprof
			third_party/test_fonts
			third_party/test_fonts/fontconfig
		)
	fi

	if ! use system-harfbuzz; then
		keeplibs+=( third_party/harfbuzz-ng )
	fi

	if ! use system-ffmpeg; then
		keeplibs+=( third_party/ffmpeg third_party/opus )
	fi

	if ! use system-icu; then
		keeplibs+=( third_party/icu )
	fi

	if ! use system-png; then
		keeplibs+=( third_party/libpng )
	fi

	if ! use system-zstd; then
		keeplibs+=( third_party/zstd )
	fi

	if ! use system-av1; then
		keeplibs+=(
			third_party/dav1d
			third_party/libaom
			third_party/libaom/source/libaom/third_party/fastfeat
			third_party/libaom/source/libaom/third_party/SVT-AV1
			third_party/libaom/source/libaom/third_party/vector
			third_party/libaom/source/libaom/third_party/x86inc
		)
	fi

	if use libcxx; then
		keeplibs+=( third_party/libc++ )
	fi

	if ! use system-openh264; then
		keeplibs+=( third_party/openh264 )
	fi

	if ! use system-re2; then
		keeplibs+=( third_party/re2 )
	fi

	if use thorium-shell; then
		keeplibs+=(
			third_party/google_benchmark/src/include/benchmark
			third_party/google_benchmark/src/src
			third_party/perfetto/protos/third_party/pprof
			third_party/quic_trace
			third_party/test_fonts
		)
	fi

	# Arch-specific
	if use arm64 || use ppc64 ; then
		keeplibs+=( third_party/swiftshader/third_party/llvm-10.0 )
	fi
	# we need to generate ppc64 stuff because upstream does not ship it yet
	# it has to be done before unbundling.
	if use ppc64; then
		pushd third_party/libvpx >/dev/null || die
		mkdir -p source/config/linux/ppc64 || die
		# requires git and clang, bug #832803
		# Revert https://chromium.googlesource.com/chromium/src/+/b463d0f40b08b4e896e7f458d89ae58ce2a27165%5E%21/third_party/libvpx/generate_gni.sh
		# and https://chromium.googlesource.com/chromium/src/+/71ebcbce867dd31da5f8b405a28fcb0de0657d91%5E%21/third_party/libvpx/generate_gni.sh
		# since we're not in a git repo
		sed -i -e "s|^update_readme||g; s|clang-format|${EPREFIX}/bin/true|g; /^git -C/d; /git cl/d; /cd \$BASE_DIR\/\$LIBVPX_SRC_DIR/ign format --in-place \$BASE_DIR\/BUILD.gn\ngn format --in-place \$BASE_DIR\/libvpx_srcs.gni" \
			generate_gni.sh || die
		./generate_gni.sh || die
		popd >/dev/null || die

		pushd third_party/ffmpeg >/dev/null || die
		cp libavcodec/ppc/h264dsp.c libavcodec/ppc/h264dsp_ppc.c || die
		cp libavcodec/ppc/h264qpel.c libavcodec/ppc/h264qpel_ppc.c || die
		popd >/dev/null || die
	fi

	# Sanity check keeplibs, on major version bumps it is often necessary to update this list
	# and this enables us to hit them all at once.
	# There are some entries that need to be whitelisted (TODO: Why? The file is understandable, the rest seem odd)
	whitelist_libs=(
		net/third_party/quic
		third_party/devtools-frontend/src/front_end/third_party/additional_readme_paths.json
		third_party/libjingle
		third_party/mesa
		third_party/skia/third_party/vulkan
		third_party/vulkan
	)
	local not_found_libs=()
	for lib in "${keeplibs[@]}"; do
		if [[ ! -d "${lib}" ]] && ! has "${lib}" "${whitelist_libs[@]}"; then
			not_found_libs+=( "${lib}" )
		fi
	done

	if [[ ${#not_found_libs[@]} -gt 0 ]]; then
		eerror "The following \`keeplibs\` directories were not found in the source tree:"
		for lib in "${not_found_libs[@]}"; do
			eerror "  ${lib}"
		done
		die "Please update the ebuild."
	fi

	# Remove most bundled libraries. Some are still needed.
	einfo "Unbundling third-party libraries ..."
	build/linux/unbundle/remove_bundled_libraries.py "${keeplibs[@]}" --do-remove || die

	# bundled eu-strip is for amd64 only and we don't want to pre-stripped binaries
	mkdir -p buildtools/third_party/eu-strip/bin || die
	ln -s "${EPREFIX}"/bin/true buildtools/third_party/eu-strip/bin/eu-strip || die
}

src_configure() {
	# Calling this here supports resumption via FEATURES=keepwork
	python_setup

	local myconf_gn=""

	# We already forced the "correct" clang via pkg_setup

	if tc-is-cross-compiler; then
		CC="${CC} -target ${CHOST} --sysroot ${ESYSROOT}"
		CXX="${CXX} -target ${CHOST} --sysroot ${ESYSROOT}"
		BUILD_AR=${AR}
		BUILD_CC=${CC}
		BUILD_CXX=${CXX}
		BUILD_NM=${NM}
	fi

	strip-unsupported-flags

	myconf_gn+=" is_clang=true clang_use_chrome_plugins=false"

	if tc-ld-is-mold; then
		myconf_gn+=" use_mold=true"
		myconf_gn+=" use_lld=false"
	else
		myconf_gn+=" use_mold=false"
		myconf_gn+=" use_lld=true"
	fi

	# Make sure the build system will use the right tools, bug #340795.
	tc-export AR CC CXX NM

	myconf_gn+=" custom_toolchain=\"//build/toolchain/linux/unbundle:default\""

	if tc-is-cross-compiler; then
		tc-export BUILD_{AR,CC,CXX,NM}
		myconf_gn+=" host_toolchain=\"//build/toolchain/linux/unbundle:host\""
		myconf_gn+=" v8_snapshot_toolchain=\"//build/toolchain/linux/unbundle:host\""
		myconf_gn+=" pkg_config=\"$(tc-getPKG_CONFIG)\""
		myconf_gn+=" host_pkg_config=\"$(tc-getBUILD_PKG_CONFIG)\""

		# setup cups-config, build system only uses --libs option
		if use cups; then
			mkdir "${T}/cups-config" || die
			cp "${ESYSROOT}/usr/bin/${CHOST}-cups-config" "${T}/cups-config/cups-config" || die
			export PATH="${PATH}:${T}/cups-config"
		fi

		# Don't inherit PKG_CONFIG_PATH from environment
		local -x PKG_CONFIG_PATH=
	else
		myconf_gn+=" host_toolchain=\"//build/toolchain/linux/unbundle:default\""
	fi

	# Disable rust for now; it's only used for testing and we don't need the additional bdep
	myconf_gn+=" enable_rust=false"

	# GN needs explicit config for Debug/Release as opposed to inferring it from build directory.
	myconf_gn+=" is_debug=$(usex debug true false)"

	# enable DCHECK with USE=debug only, increases chrome binary size by 30%, bug #811138.
	# DCHECK is fatal by default, make it configurable at runtime, #bug 807881.
	myconf_gn+=" dcheck_always_on=$(usex debug true false)"
	myconf_gn+=" dcheck_is_configurable=$(usex debug true false)"

	# Component build isn't generally intended for use by end users. It's mostly useful
	# for development and debugging.
	myconf_gn+=" is_component_build=false"

	# Disable nacl, we can't build without pnacl (http://crbug.com/269560).
	myconf_gn+=" enable_nacl=false"

	local gn_system_libraries=(
		flac
		fontconfig
		freetype
		libdrm
		libjpeg
		libwebp
		libxml
		libxslt
		zlib
	)
	if use system-brotli; then
		gn_system_libraries+=( brotli )
	fi
	if use system-crc32c; then
		gn_system_libraries+=( crc32c )
	fi
	if use system-double-conversion; then
		gn_system_libraries+=( double-conversion )
	fi
	if use system-woff2; then
		gn_system_libraries+=( woff2 )
	fi
	if use nvidia; then
		gn_system_libraries+=( libXNVCtrl )
	fi
	if use system-ffmpeg; then
		gn_system_libraries+=( ffmpeg opus )
	fi
	if use system-jsoncpp; then
		gn_system_libraries+=( jsoncpp )
	fi
	if use system-icu; then
		gn_system_libraries+=( icu )
	fi
	if use system-png; then
		gn_system_libraries+=( libpng )
		myconf_gn+=" use_system_libpng=true"
	fi
	if use system-zstd; then
		gn_system_libraries+=( zstd )
	fi
	if use system-av1; then
		gn_system_libraries+=( dav1d libaom )
	fi
	if use system-libusb; then
		gn_system_libraries+=( libusb )
	fi
	if use system-libvpx; then
		gn_system_libraries+=( libvpx )
	fi
	if use thorium-libjxl; then
		gn_system_libraries+=( libjxl )
	fi
	if use system-libevent; then
		gn_system_libraries+=( libevent )
	fi
	use system-openh264 && gn_system_libraries+=(
		openh264
	)
	use system-re2 && gn_system_libraries+=(
		re2
	)
	use system-snappy && gn_system_libraries+=(
		snappy
	)

	build/linux/unbundle/replace_gn_files.py --system-libraries "${gn_system_libraries[@]}" || die

	# See dependency logic in third_party/BUILD.gn
	myconf_gn+=" use_system_harfbuzz=$(usex system-harfbuzz true false)"

	# Optional dependencies.
	myconf_gn+=" enable_hangout_services_extension=$(usex hangouts true false)"
	myconf_gn+=" enable_widevine=$(usex widevine true false)"

	if use headless; then
		myconf_gn+=" use_cups=false"
		myconf_gn+=" use_kerberos=false"
		myconf_gn+=" use_pulseaudio=false"
		myconf_gn+=" use_vaapi=false"
		myconf_gn+=" rtc_use_pipewire=false"
	else
		myconf_gn+=" use_cups=$(usex cups true false)"
		myconf_gn+=" use_kerberos=$(usex kerberos true false)"
		myconf_gn+=" use_pulseaudio=$(usex pulseaudio true false)"
		myconf_gn+=" use_vaapi=$(usex vaapi true false)"
		myconf_gn+=" rtc_use_pipewire=$(usex screencast true false)"
		myconf_gn+=" gtk_version=$(usex gtk4 4 3)"
	fi

	# Allows distributions to link pulseaudio directly (DT_NEEDED) instead of
	# using dlopen. This helps with automated detection of ABI mismatches and
	# prevents silent errors.
	if use pulseaudio; then
		myconf_gn+=" link_pulseaudio=true"
	fi

	# Non-developer builds of Chromium (for example, non-Chrome browsers, or
	# Chromium builds provided by Linux distros) should disable the testing config
	myconf_gn+=" disable_fieldtrial_testing_config=true"

	# The sysroot is the oldest debian image that chromium supports, we don't need it
	myconf_gn+=" use_sysroot=false"

	# This determines whether or not GN uses the bundled libcxx
	if use libcxx; then
		myconf_gn+=" use_custom_libcxx=true"
	else
		myconf_gn+=" use_custom_libcxx=false"
		append-cppflags -U_GLIBCXX_ASSERTIONS # See #318
	fi

	myconf_gn+=" use_bluez=$(usex bluetooth true false)"

	myconf_gn+=" is_cfi=$(usex cfi true false)"

	if use cfi; then
		myconf_gn+=" use_cfi_icall=true"
		myconf_gn+=" use_cfi_cast=true"
	fi

	if use pgo; then
		myconf_gn+=" chrome_pgo_phase=2"
		myconf_gn+=" v8_enable_builtins_optimization=true"
	else
		myconf_gn+=" chrome_pgo_phase=0"
	fi

	myconf_gn+=" optimize_webui=$(usex optimize-webui true false)"
	myconf_gn+=" use_system_freetype=$(usex system-harfbuzz true false)"
	myconf_gn+=" use_system_libopenjpeg2=$(usex system-openjpeg true false)"
	myconf_gn+=" enable_pdf=true"
	myconf_gn+=" use_system_lcms2=true"
	myconf_gn+=" enable_print_preview=true"
	myconf_gn+=" enable_platform_hevc=$(usex hevc true false)"
	myconf_gn+=" enable_hevc_parser_and_hw_decoder=$(usex hevc true false)"

	# Ungoogled flags
	myconf_gn+=" build_with_tflite_lib=false"
	myconf_gn+=" enable_mse_mpeg2ts_stream_parser=$(usex proprietary-codecs true false)"
	myconf_gn+=" enable_reading_list=false"
	myconf_gn+=" enable_remoting=false"
	myconf_gn+=" enable_reporting=false"
	if use ungoogled; then
	myconf_gn+=" enable_mdns=false"
	myconf_gn+=" enable_service_discovery=false"
	fi
	myconf_gn+=" exclude_unwind_tables=true"
	myconf_gn+=" google_api_key=\"\""
	myconf_gn+=" google_default_client_id=\"\""
	myconf_gn+=" google_default_client_secret=\"\""
	# https://github.com/Alex313031/thorium/issues/978
	if use ungoogled; then
	myconf_gn+=" safe_browsing_mode=0"
	fi
	myconf_gn+=" use_official_google_api_keys=false"
	myconf_gn+=" use_unofficial_version_number=false"

	# myconf_gn+=" enable_swiftshader=false"

	# Additional flags
	myconf_gn+=" perfetto_use_system_zlib=true"
	myconf_gn+=" use_system_zlib=true"
	myconf_gn+=" use_system_libjpeg=true"
	myconf_gn+=" rtc_build_examples=false"
	myconf_gn+=" enable_chromium_prelude=false"
	myconf_gn+=" enable_updater=false"
	myconf_gn+=" enable_update_notifications=false"

	# Disable pseudolocales, only used for testing
	myconf_gn+=" enable_pseudolocales=false"

	# Disable code formating of generated files
	myconf_gn+=" blink_enable_generated_code_formatting=false"

	ffmpeg_branding="$(usex proprietary-codecs Chrome Chromium)"
	myconf_gn+=" proprietary_codecs=$(usex proprietary-codecs true false)"
	myconf_gn+=" ffmpeg_branding=\"${ffmpeg_branding}\""

	local myarch="$(tc-arch)"

	# Avoid CFLAGS problems
	if ! use custom-cflags; then
		filter-flags "-O*" "-Wl,-O*" # See #25
		strip-flags

		# Prevent linker from running out of address space, bug #471810 .
		if use x86; then
			filter-flags "-g*"
		fi

		# Prevent libvpx/xnnpack build failures. Bug 530248, 544702, 546984, 853646.
		if [[ ${myarch} == amd64 || ${myarch} == x86 ]]; then
			filter-flags -mno-mmx -mno-sse2 -mno-ssse3 -mno-sse4.1 -mno-avx -mno-avx2 -mno-fma -mno-fma4 -mno-xop -mno-sse4a
		fi
	fi

	if [[ $myarch = amd64 ]] ; then
		myconf_gn+=" target_cpu=\"x64\""
		ffmpeg_target_arch=x64
	elif [[ $myarch = x86 ]] ; then
		myconf_gn+=" target_cpu=\"x86\""
		ffmpeg_target_arch=ia32

		# This is normally defined by compiler_cpu_abi in
		# build/config/compiler/BUILD.gn, but we patch that part out.
		append-flags -msse2 -mfpmath=sse -mmmx
	elif [[ $myarch = arm64 ]] ; then
		myconf_gn+=" target_cpu=\"arm64\""
		ffmpeg_target_arch=arm64
	elif [[ $myarch = ppc64 ]] ; then
		myconf_gn+=" target_cpu=\"ppc64\""
		ffmpeg_target_arch=ppc64
	else
		die "Failed to determine target arch, got '$myarch'."
	fi

	myconf_gn+=" treat_warnings_as_errors=false"
	# Disable fatal linker warnings, bug 506268.
	myconf_gn+=" fatal_linker_warnings=false"

	# Disable external code space for V8 for ppc64. It is disabled for ppc64
	# by default, but cross-compiling on amd64 enables it again.
	if tc-is-cross-compiler; then
		if ! use amd64 && ! use arm64; then
			myconf_gn+=" v8_enable_external_code_space=false"
		fi
	fi

	# Only enabled for clang, but gcc has endian macros too
	myconf_gn+=" v8_use_libm_trig_functions=true"

	# Bug 491582.
	export TMPDIR="${WORKDIR}/temp"
	mkdir -p -m 755 "${TMPDIR}" || die

	# https://bugs.gentoo.org/654216
	addpredict /dev/dri/ #nowarn

	# We don't use the same clang version as upstream, and with -Werror
	# we need to make sure that we don't get superfluous warnings.
	append-flags -Wno-unknown-warning-option
	if tc-is-cross-compiler; then
		export BUILD_CXXFLAGS+=" -Wno-unknown-warning-option"
		export BUILD_CFLAGS+=" -Wno-unknown-warning-option"
	fi

	# Explicitly disable ICU data file support for system-icu/headless builds.
	if use system-icu || use headless; then
		myconf_gn+=" icu_use_data_file=false"
	fi

	# Don't need nocompile checks and GN crashes with our config
	myconf_gn+=" enable_nocompile_tests=false"

	# Enable ozone wayland and/or headless support
	myconf_gn+=" use_ozone=true ozone_auto_platforms=false"
	myconf_gn+=" ozone_platform_headless=true"
	if use headless; then
		myconf_gn+=" ozone_platform=\"headless\""
		myconf_gn+=" use_xkbcommon=false use_gtk=false use_qt=false"
		myconf_gn+=" use_glib=false use_gio=false"
		myconf_gn+=" use_pangocairo=false use_alsa=false"
		myconf_gn+=" use_libpci=false use_udev=false"
		myconf_gn+=" enable_print_preview=false"
		myconf_gn+=" enable_remoting=false"
	else
		myconf_gn+=" use_system_minigbm=true"
		myconf_gn+=" use_xkbcommon=true"
		myconf_gn+=" use_qt5=false"
		if use qt6; then
			myconf_gn+=" use_qt6=true"
			local cbuild_libdir=$(get_libdir)
			if tc-is-cross-compiler; then
				# Hack to workaround get_libdir not being able to handle CBUILD, bug #794181
				local cbuild_libdir=$($(tc-getBUILD_PKG_CONFIG) --keep-system-libs --libs-only-L libxslt)
				cbuild_libdir=${cbuild_libdir:2}
				cbuild_libdir=${cbuild_libdir/% }
			fi
			myconf_gn+=" moc_qt6_path=\"${EPREFIX}/usr/${cbuild_libdir}/qt6/libexec\""
		else
			myconf_gn+=" use_qt6=false"
		fi
		myconf_gn+=" ozone_platform_x11=$(usex X true false)"
		myconf_gn+=" ozone_platform_wayland=$(usex wayland true false)"
		myconf_gn+=" ozone_platform=$(usex wayland \"wayland\" \"x11\")"
		use wayland && myconf_gn+=" use_system_libffi=true"
	fi

	# Results in undefined references in chrome linking, may require CFI to work
	if use arm64; then
		myconf_gn+=" arm_control_flow_integrity=\"none\""
	fi

	myconf_gn+=" use_thin_lto=${use_lto}"
	myconf_gn+=" thin_lto_enable_optimizations=${use_lto}"

	# Enable official builds
	myconf_gn+=" is_official_build=$(usex official true false)"
	if use official; then
		# Allow building against system libraries in official builds
		sed -i 's/OFFICIAL_BUILD/GOOGLE_CHROME_BUILD/' \
			tools/generate_shim_headers/generate_shim_headers.py || die
		# Don't add symbols to build
		myconf_gn+=" symbol_level=0"
	else
		myconf_gn+=" devtools_skip_typecheck=false" # See #142
	fi

	# skipping typecheck is only supported on amd64, bug #876157
	if ! use amd64; then
		myconf_gn+=" devtools_skip_typecheck=false"
	fi

	einfo "Configuring Thorium ..."
	set -- gn gen --args="${myconf_gn} ${EXTRA_GN}" out/thorium
	echo "$@"
	"$@" || die
}

src_compile() {
	# Final link uses lots of file descriptors.
	# Much larger, required by mold, https://github.com/rui314/mold/issues/336
	ulimit -n 1048576

	# Calling this here supports resumption via FEATURES=keepwork
	python_setup

	# Don't inherit PYTHONPATH from environment, bug #789021, #812689
	local -x PYTHONPATH=

	use convert-dict && eninja -C out/thorium convert_dict

	# Build mksnapshot and pax-mark it.
	if use pax-kernel; then
		local x
		for x in mksnapshot v8_context_snapshot_generator; do
			if tc-is-cross-compiler; then
				eninja -C out/thorium "host/${x}"
				pax-mark m "out/thorium/host/${x}"
			else
				eninja -C out/thorium "${x}"
				pax-mark m "out/thorium/${x}"
			fi
		done
	fi

	# Even though ninja autodetects number of CPUs, we respect
	# user's options, for debugging with -j 1 or any other reason.
	eninja -C out/thorium thorium $(use test && echo "base_unittests")

	use enable-driver && eninja -C out/thorium chromedriver
	use thorium-shell && eninja -C out/thorium thorium_shell
	#use suid && eninja -C out/thorium chrome_sandbox

	pax-mark m out/thorium/thorium

	use enable-driver && mv out/thorium/chromedriver{.unstripped,}

	rm -f out/thorium/locales/*.pak.info || die

	# Build manpage; bug #684550
	sed -e 's|@@PACKAGE@@|thorium-browser|g;
		s|@@MENUNAME@@|Thorium|g;' \
		chrome/app/resources/manpage.1.in > \
		out/thorium/thorium-browser.1 || die

	# Build desktop file; bug #706786
	#sed -e 's|@@MENUNAME@@|Thorium|g;
	# 	s|@@USR_BIN_SYMLINK_NAME@@|thorium-browser|g;
	# 	s|@@PACKAGE@@|thorium-browser|g;
	# 	s|\(^Exec=\)/usr/bin/|\1|g;' \
	# 	chrome/installer/linux/common/desktop.template > \
	# 	out/thorium/thorium-browser-thorium.desktop || die

	# Build vk_swiftshader_icd.json; bug #827861
	sed -e 's|${ICD_LIBRARY_PATH}|./libvk_swiftshader.so|g' \
		third_party/swiftshader/src/Vulkan/vk_swiftshader_icd.json.tmpl > \
		out/thorium/vk_swiftshader_icd.json || die
}

src_test() {
	# Initial list of tests to skip pulled from Alpine. Thanks Lauren!
	# https://issues.chromium.org/issues/40939315
	local skip_tests=(
		'MessagePumpLibeventTest.NestedNotification*'
		ClampTest.Death
		OptionalTest.DereferencingNoValueCrashes
		PlatformThreadTest.SetCurrentThreadTypeTest
		RawPtrTest.TrivialRelocability
		SafeNumerics.IntMaxOperations
		StackTraceTest.TraceStackFramePointersFromBuffer
		StringPieceTest.InvalidLengthDeath
		StringPieceTest.OutOfBoundsDeath
		ThreadPoolEnvironmentConfig.CanUseBackgroundPriorityForWorker
		ValuesUtilTest.FilePath
		# Gentoo-specific
		AlternateTestParams/PartitionAllocDeathTest.RepeatedAllocReturnNullDirect/0
		AlternateTestParams/PartitionAllocDeathTest.RepeatedAllocReturnNullDirect/1
		AlternateTestParams/PartitionAllocDeathTest.RepeatedAllocReturnNullDirect/2
		AlternateTestParams/PartitionAllocDeathTest.RepeatedAllocReturnNullDirect/3
		AlternateTestParams/PartitionAllocDeathTest.RepeatedReallocReturnNullDirect/0
		AlternateTestParams/PartitionAllocDeathTest.RepeatedReallocReturnNullDirect/1
		AlternateTestParams/PartitionAllocDeathTest.RepeatedReallocReturnNullDirect/2
		AlternateTestParams/PartitionAllocDeathTest.RepeatedReallocReturnNullDirect/3
		CharacterEncodingTest.GetCanonicalEncodingNameByAliasName
		CheckExitCodeAfterSignalHandlerDeathTest.CheckSIGFPE
		CheckExitCodeAfterSignalHandlerDeathTest.CheckSIGILL
		CheckExitCodeAfterSignalHandlerDeathTest.CheckSIGSEGV
		CheckExitCodeAfterSignalHandlerDeathTest.CheckSIGSEGVNonCanonicalAddress
		FilePathTest.FromUTF8Unsafe_And_AsUTF8Unsafe
		ICUStringConversionsTest.ConvertToUtf8AndNormalize
		NumberFormattingTest.FormatPercent
		PathServiceTest.CheckedGetFailure
		PlatformThreadTest.CanChangeThreadType
		StackCanary.ChangingStackCanaryCrashesOnReturn
		StackTraceDeathTest.StackDumpSignalHandlerIsMallocFree
		SysStrings.SysNativeMBAndWide
		SysStrings.SysNativeMBToWide
		SysStrings.SysWideToNativeMB
		TestLauncherTools.TruncateSnippetFocusedMatchesFatalMessagesTest
		ToolsSanityTest.BadVirtualCallNull
		ToolsSanityTest.BadVirtualCallWrongType
	)

	local test_filter="-$(IFS=:; printf '%s' "${skip_tests[*]}")"
	# test-launcher-bot-mode enables parallelism and plain output
	./out/thorium/base_unittests --test-launcher-bot-mode \
		--test-launcher-jobs="$(makeopts_jobs)" \
		--gtest_filter="${test_filter}" || die "Tests failed!"
}

src_install() {
	local CHROMIUM_HOME="/usr/$(get_libdir)/thorium"
	exeinto "${CHROMIUM_HOME}"
	doexe out/thorium/thorium

	if use convert-dict; then
		newexe "${FILESDIR}/update-dicts.sh" update-dicts.sh
		doexe out/thorium/convert_dict
	fi

	#if use suid; then
	#	newexe out/thorium/chrome_sandbox chrome-sandbox
	#	fperms 4755 "${CHROMIUM_HOME}/chrome-sandbox"
	#fi

	use enable-driver && doexe out/thorium/chromedriver
	use thorium-shell && doexe out/thorium/thorium_shell
	#doexe out/thorium/chrome_crashpad_handler

	ozone_auto_session () {
		use X && use wayland && ! use headless && echo true || echo false
	}
	local sedargs=( -e
			"s:/usr/lib/:/usr/$(get_libdir)/:g;
			s:@@OZONE_AUTO_SESSION@@:$(ozone_auto_session):g"
	)
	sed "${sedargs[@]}" "${FILESDIR}/thorium-launcher.sh" > thorium-launcher.sh || die
	doexe thorium-launcher.sh

	# It is important that we name the target "chromium-browser",
	# xdg-utils expect it; bug #355517.
	dosym "${CHROMIUM_HOME}/thorium-launcher.sh" /usr/bin/thorium-browser
	# keep the old symlink around for consistency
	dosym "${CHROMIUM_HOME}/thorium-launcher.sh" /usr/bin/thorium

	use enable-driver && dosym "${CHROMIUM_HOME}/chromedriver" /usr/bin/chromedriver
	if use thorium-shell; then
		doexe "${FILESDIR}/thorium-shell-launcher.sh"
		dosym "${CHROMIUM_HOME}/thorium-shell-launcher.sh" /usr/bin/thorium-shell
	fi

	# Allow users to override command-line options, bug #357629.
	insinto /etc/thorium
	newins "${FILESDIR}/thorium.default" "default"

	if use thorium-shell; then
		insinto /etc/thorium-shell
		newins "${FILESDIR}/thorium-shell.default" "default"
	fi

	pushd out/thorium/locales > /dev/null || die
	chromium_remove_language_paks
	popd

	insinto "${CHROMIUM_HOME}"
	doins out/thorium/*.bin
	doins out/thorium/*.pak
	(
		shopt -s nullglob
		local files=(out/thorium/*.so out/thorium/*.so.[0-9])
		[[ ${#files[@]} -gt 0 ]] && doins "${files[@]}"
	)

	# Install bundled xdg-utils, avoids installing X11 libraries with USE="-X wayland"
	doins out/thorium/xdg-{settings,mime}

	if ! use system-icu && ! use headless; then
		doins out/thorium/icudtl.dat
	fi

	doins -r out/thorium/locales
	#doins -r out/thorium/MEIPreload

	# Install vk_swiftshader_icd.json; bug #827861
	doins out/thorium/vk_swiftshader_icd.json

	if [[ -d out/thorium/swiftshader ]]; then
		insinto "${CHROMIUM_HOME}/swiftshader"
		doins out/thorium/swiftshader/*.so
	fi

	use widevine && dosym WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so "${CHROMIUM_HOME}/libwidevinecdm.so"

	# Install icons
	local branding size
	for size in 16 24 32 48 64 128 256 ; do
		newicon -s ${size} "${THORIUM_WD}/logos/NEW/product_logo_${size}.png" \
			thorium-browser.png
	done
	if use thorium-shell; then
		for size in 16 24 32 48 64 128 256 ; do
			newicon -s ${size} "${THORIUM_WD}/logos/NEW/thorium_shell/thorium-devtools-${size}.png" \
				thorium-shell.png
		done
	fi

	# Install desktop entry
	sed -i -e 's|./thorium-browser|/usr/bin/thorium-browser|' \
		-e 's/Icon=product_logo_256.png/Icon=thorium-browser/' \
		"${THORIUM_WD}/infra/portable/thorium-portable.desktop" || die
	newmenu "${THORIUM_WD}/infra/portable/thorium-portable.desktop" thorium-browser-thorium.desktop
	if use thorium-shell; then
		domenu "${FILESDIR}/thorium-shell.desktop"
	fi

	# Install GNOME default application entry (bug #303100).
	insinto /usr/share/gnome-control-center/default-apps
	newins "${FILESDIR}"/thorium-browser.xml thorium-browser.xml

	# Install manpage; bug #684550
	doman out/thorium/thorium-browser.1
	dosym thorium-browser.1 /usr/share/man/man1/thorium.1

	readme.gentoo_create_doc
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	readme.gentoo_print_elog

	if ! use headless; then
		if use vaapi; then
			elog "VA-API is disabled by default at runtime. You have to enable it"
			elog "by adding --enable-features=VaapiVideoDecoder to CHROMIUM_FLAGS"
			elog "in /etc/thorium/default."
		fi
		if use screencast; then
			elog "Screencast is disabled by default at runtime. Either enable it"
			elog "by navigating to chrome://flags/#enable-webrtc-pipewire-capturer"
			elog "inside Chromium or add --enable-features=WebRTCPipeWireCapturer"
			elog "to CHROMIUM_FLAGS in /etc/thorium/default."
			elog
			elog "Additional setup may be required for screencasting to work."
			elog "See issue: https://github.com/PF4Public/gentoo-overlay/issues/314"
		fi
		if use gtk4; then
			elog "Chromium prefers GTK3 over GTK4 at runtime. To override this"
			elog "behaviour you need to pass --gtk-version=4, e.g. by adding it"
			elog "to CHROMIUM_FLAGS in /etc/thorium/default."
		fi
		if use widevine; then
			elog "widevine requires binary plugins, which are distributed separately"
			elog "Make sure you have www-plugins/chrome-binary-plugins installed"
		fi
	fi

	if systemd_is_booted && ! [[ -f "/etc/machine-id" ]]; then
		ewarn "The lack of an '/etc/machine-id' file on this system booted with systemd"
		ewarn "indicates that the Gentoo handbook was not followed to completion."
		ewarn ""
		ewarn "Chromium is known to behave unpredictably with this system configuration;"
		ewarn "please complete the configuration of this system before logging any bugs."
	fi
}
