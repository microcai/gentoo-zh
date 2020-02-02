# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
inherit cmake-utils flag-o-matic python-any-r1 toolchain-funcs \
	desktop xdg \
	git-r3

DESCRIPTION="Official desktop client for Telegram"
HOMEPAGE="https://desktop.telegram.org"

EGIT_REPO_URI="https://github.com/telegramdesktop/tdesktop.git"
EGIT_SUBMODULES=(
	'*'
	'-Telegram/ThirdParty/Catch'
	'-Telegram/ThirdParty/lz4'
)

if [[ ${PV} == 9999 ]]
then
	EGIT_BRANCH="dev"
	KEYWORDS=""
else
	EGIT_COMMIT="v${PV}"
	RANGE_V3_VER="0.10.0"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
IUSE="crashreporter custom-api-id +pulseaudio +spell test"

# due to missing WITHOUT_PULSE in Telegram/cmake/lib_tgvoip.cmake:
REQUIRED_USE="pulseaudio"

BDEPEND=">=dev-util/cmake-3.16" 
RDEPEND="
	app-arch/lz4
	app-arch/xz-utils
	dev-libs/openssl:0
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[jpeg,png,xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtimageformats:5
	dev-qt/qtwidgets:5[png,xcb]
	media-libs/openal
	media-libs/opus
	sys-libs/zlib[minizip]
	virtual/ffmpeg
	x11-libs/libva[X,drm]
	x11-libs/libX11
	!net-im/telegram-desktop-bin
	crashreporter? ( dev-util/google-breakpad )
	pulseaudio? ( media-sound/pulseaudio )
	spell? ( app-text/enchant )
	test? ( dev-cpp/catch )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"


PATCHES=( "${FILESDIR}/patches" )

pkg_pretend() {
	if use custom-api-id
	then
		[[ -n "${API_ID}" ]] && \
		[[ -n "${API_HASH}" ]] && (
			einfo "Will be used custom 'api_id' and 'api_hash':"
			einfo "API_ID=${API_ID}"
			einfo "API_HASH=${API_HASH//[!\*]/*}"
		) || (
			eerror "It seems you did not set one or both of"
			eerror "API_ID and API_HASH variables,"
			eerror "which are required for custom-api-id USE-flag."
			eerror "You can set them either in your env or bashrc."
			die
		)
	fi

	if tc-is-gcc && [[ $(gcc-major-version) -lt 7 ]]
	then
		die "At least gcc 7.0 is required"
	fi
}

src_unpack() {
	git-r3_src_unpack

	unset EGIT_COMMIT
	unset EGIT_COMMIT_DATE
	unset EGIT_SUBMODULES

	EGIT_REPO_URI="https://github.com/ericniebler/range-v3.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/Libraries/range-v3"

	if [[ ${PV} == 9999 ]]
	then
		EGIT_COMMIT_DATE=$(GIT_DIR="${S}/.git" git show -s --format=%ct || die)
	else
		EGIT_COMMIT="${RANGE_V3_VER}"
	fi

	git-r3_src_unpack
}

src_prepare() {
	cp "${FILESDIR}"/external.cmake cmake
	cat "${FILESDIR}"/install.cmake >> Telegram/CMakeLists.txt
	echo > cmake/options_linux.cmake

	sed -i \
		-e '/add_subdirectory.*crash_reports/d' \
		-e '/add_subdirectory.*ffmpeg/d' \
		-e '/add_subdirectory.*lz4/d' \
		-e '/add_subdirectory.*openal/d' \
		-e '/add_subdirectory.*openssl/d' \
		-e '/add_subdirectory.*opus/d' \
		-e '/add_subdirectory.*qt/d' \
		-e '/add_subdirectory.*zlib/d' \
		cmake/external/CMakeLists.txt || die

	sed -i \
		-e '/LINK_SEARCH_START_STATIC/d' \
		cmake/init_target.cmake || die

	sed -i \
		-e 's#include.*cmake.*external.*#include(cmake/external.cmake)#' \
		CMakeLists.txt || die

	sed -i \
		-e '/ayatana-appindicator/d' \
		-e '/qt_static_plugins/a qt_functions.cpp' \
		-e '/third_party_loc.*minizip/d' \
		-e 's/\(pkg_check_modules.*gtk+\)-2\.0/\1-3.0/' \
		-e 's/\(pkg_check_modules.*APPIND[^[:space:]]\+\)/\1 REQUIRED/' \
		-e 's/if.*NOT[[:space:]]*build_macstore.*/if(False)/' \
		Telegram/CMakeLists.txt || die

	sed -i \
		-e '/Q_IMPORT_PLUGIN/d' \
		Telegram/SourceFiles/qt_static_plugins.cpp || die

	sed -i \
		-e '1s:^:#include <QtCore/QVersionNumber>\n:' \
		Telegram/SourceFiles/platform/linux/notifications_manager_linux.cpp || die

	if use !crashreporter
	then
		sed -i \
			-e '/external_crash_reports/d' \
			Telegram/lib_base/CMakeLists.txt || die
	else
		sed -i \
			-e 's:\(#include.*\)\"\(client.*handler.*\)\":\1<\2>:' \
			Telegram/lib_base/base/crash_report_writer.cpp || die
	fi

	if use !custom-api-id
	then
		sed -i -e '/error.*API_ID.*API_HASH/d' \
			Telegram/SourceFiles/config.h || die
	fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycxxflags=(
		-Wno-deprecated-declarations
		-Wno-error=deprecated-declarations
		-Wno-switch
	)

	append-cppflags ${mycxxflags[@]}

	local mycmakeargs=(
		-DDESKTOP_APP_DISABLE_CRASH_REPORTS=$(usex !crashreporter)
		-DDESKTOP_APP_DISABLE_SPELLCHECK=$(usex !spell)
		-DTDESKTOP_API_TEST=$(usex !custom-api-id)
		-DTDESKTOP_DISABLE_DESKTOP_FILE_GENERATION=ON
		-DTDESKTOP_DISABLE_GTK_INTEGRATION=ON
		-DTDESKTOP_FORCE_GTK_FILE_DIALOG=OFF
		-DTDESKTOP_API_ID=${API_ID}
		-DTDESKTOP_API_HASH=${API_HASH}
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	default

	local icon_size
	for icon_size in 16 32 48 64 128 256 512
	do
		newicon -s ${icon_size} \
			Telegram/Resources/art/icon${icon_size}.png telegram.png
	done

	newmenu lib/xdg/telegramdesktop.desktop telegram-desktop.desktop
}
