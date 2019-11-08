# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION="3.8"

inherit cmake-utils desktop flag-o-matic git-r3 gnome2-utils toolchain-funcs xdg

DESCRIPTION="Official desktop client for Telegram"
HOMEPAGE="https://desktop.telegram.org"

EGIT_REPO_URI="https://github.com/telegramdesktop/tdesktop.git"
EGIT_SUBMODULES=(
	Telegram/lib_crl
	Telegram/lib_tl
	Telegram/lib_rpl
	Telegram/lib_base
	Telegram/lib_ui
	Telegram/lib_lottie
	Telegram/lib_spellcheck
	Telegram/codegen
	Telegram/ThirdParty/libtgvoip
	Telegram/ThirdParty/variant
	Telegram/ThirdParty/GSL
	Telegram/ThirdParty/rlottie
)

if [[ ${PV} == 9999 ]]; then
	EGIT_BRANCH="dev"
	KEYWORDS=""
else
	EGIT_COMMIT="v${PV}"
	RANGE_V3_VER="0.9.1"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
IUSE="crashreporter custom-api-id debug effects gtk3 pulseaudio test"

RDEPEND="
	dev-libs/openssl:0
	dev-libs/rapidjson
	dev-libs/xxhash
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[jpeg,png,xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtimageformats:5
	dev-qt/qtwidgets:5[png,xcb]
	media-libs/opus
	sys-libs/zlib[minizip]
	virtual/ffmpeg
	x11-libs/libdrm
	x11-libs/libva[X,drm]
	x11-libs/libX11
	!net-im/telegram-desktop-bin
	crashreporter? ( dev-util/google-breakpad )
	effects? ( >=media-libs/openal-1.19.0 )
	!effects? ( media-libs/openal )
	gtk3? (
		x11-libs/gtk+:3
		dev-libs/libappindicator:3
		dev-qt/qtgui:5[gtk(+)]
	)
	pulseaudio? ( media-sound/pulseaudio )
	test? ( dev-cpp/catch )
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

CMAKE_MIN_VERSION="3.8"
CMAKE_USE_DIR="${S}/Telegram"

PATCHES=( "${FILESDIR}/patches" )

pkg_pretend() {
	if use custom-api-id; then
		[[ -n "${TDESKTOP_API_ID}" ]] && \
		[[ -n "${TDESKTOP_API_HASH}" ]] && (
			einfo "Will be used custom 'api_id' and 'api_hash':"
			einfo "TDESKTOP_API_ID=${TDESKTOP_API_ID}"
			einfo "TDESKTOP_API_HASH=${TDESKTOP_API_HASH//[!\*]/*}"
		) || (
			eerror "It seems you did not set one or both of"
			eerror "TDESKTOP_API_ID and TDESKTOP_API_HASH variables,"
			eerror "which are required for custom-api-id USE-flag."
			eerror "You can set them either in your env or bashrc."
			die
		)
	fi

	if tc-is-gcc && [[ $(gcc-major-version) -lt 7 ]] ; then
		die "At least gcc 7.0 is required"
	fi
}

src_unpack() {
	git-r3_src_unpack

	unset EGIT_COMMIT
	unset EGIT_COMMIT_DATE
	unset EGIT_SUBMODULES

	EGIT_REPO_URI="https://github.com/ericniebler/range-v3.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/range-v3"

	if [[ ${PV} == 9999 ]]; then
		EGIT_COMMIT_DATE=$(GIT_DIR="${S}/.git" git show -s --format=%ct || die)
	else
		EGIT_COMMIT="${RANGE_V3_VER}"
	fi

	git-r3_src_unpack
}

src_prepare() {
	local CMAKE_MODULES_DIR="${S}/Telegram/cmake"
	local THIRD_PARTY_DIR="${S}/Telegram/ThirdParty"
	local LIBTGVOIP_DIR="${THIRD_PARTY_DIR}/libtgvoip"

	cp "${FILESDIR}/Telegram.cmake" "${S}/Telegram/CMakeLists.txt"
	cp "${FILESDIR}/ThirdParty-crl.cmake" "${S}/Telegram/lib_crl/CMakeLists.txt"
	cp "${FILESDIR}/ThirdParty-libtgvoip.cmake" "${LIBTGVOIP_DIR}/CMakeLists.txt"
	cp "${FILESDIR}/ThirdParty-rlottie.cmake" "${THIRD_PARTY_DIR}/rlottie/CMakeLists.txt"
	cp "${FILESDIR}/linux.qrc" "${S}/Telegram/lib_ui/qt_conf/linux.qrc"

	mkdir "${CMAKE_MODULES_DIR}" || die
	cp "${FILESDIR}/FindBreakpad.cmake" "${CMAKE_MODULES_DIR}"
	cp "${FILESDIR}/TelegramCodegen.cmake" "${CMAKE_MODULES_DIR}"
	cp "${FILESDIR}/TelegramCodegenTools.cmake" "${CMAKE_MODULES_DIR}"
	cp "${FILESDIR}/TelegramTests.cmake" "${CMAKE_MODULES_DIR}"

	cp "${FILESDIR}/ffmpeg_utility.cpp" Telegram/SourceFiles/ffmpeg/
	cp "${FILESDIR}/qt_functions.cpp" Telegram/SourceFiles/

	cmake-utils_src_prepare

	if ! use custom-api-id; then
		sed -i -e '/error.*API_ID.*API_HASH/d' \
			Telegram/SourceFiles/config.h || die
	fi
}

src_configure() {
	local mycxxflags=(
		-DLIBDIR="$(get_libdir)"
		-I"${WORKDIR}/range-v3/include"
	)

	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS:="${mycxxflags[*]}"
		-DBUILD_TESTS=$(usex test)
		-DENABLE_CRASH_REPORTS=$(usex crashreporter)
		-DENABLE_GTK_INTEGRATION=$(usex gtk3)
		-DENABLE_OPENAL_EFFECTS=$(usex effects)
		-DENABLE_PULSEAUDIO=$(usex pulseaudio)
	)

	if ! use custom-api-id; then
		unset TDESKTOP_API_ID
		unset TDESKTOP_API_HASH
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	default

	local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${S}/Telegram/Resources/art/icon${icon_size}.png" \
			telegram.png
	done

	newmenu "${S}"/lib/xdg/telegramdesktop.desktop telegram-desktop.desktop
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
