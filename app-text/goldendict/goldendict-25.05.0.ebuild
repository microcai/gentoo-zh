# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PLOCALES="ar_SA ay_BO be_BY bg_BG crowdin cs_CZ de_CH de_DE el_GR eo_UY es_AR
es_BO es_ES fa_IR fi_FI fr_FR hi_IN hu_HU ie_001 it_IT ja_JP jbo_EN kab_KAB
ko_KR lt_LT mk_MK nl_NL pl_PL pt_BR pt_PT qu_PE ru_RU sk_SK sq_AL sr_SP
sv_SE tg_TJ tk_TM tr_TR uk_UA vi_VN zh_CN zh_TW"

inherit cmake flag-o-matic plocale xdg

MY_PV="25.05.0-Release.2a2b0e16"

DESCRIPTION="Feature-rich dictionary lookup program (qtwebengine fork)"
HOMEPAGE="https://xiaoyifang.github.io/goldendict-ng/"
SRC_URI="
	https://github.com/xiaoyifang/goldendict-ng/archive/v${MY_PV}.tar.gz -> ${PN}-ng-${MY_PV}.tar.gz
"
S="${WORKDIR}/goldendict-ng-${MY_PV}"

LICENSE="
	GPL-3
	!systemfmt? ( MIT )
	!systemtoml? ( MIT )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ffmpeg epwing systemfmt systemtoml tts zim"

DEPEND="
	app-arch/bzip2
	app-arch/lzma
	app-arch/xz-utils
	app-i18n/opencc
	app-text/hunspell
	dev-libs/eb
	dev-libs/lzo:2
	dev-libs/xapian
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[dbus,concurrent,cups,gui,network,sql,widgets,xml,X]
	dev-qt/qtmultimedia:6
	dev-qt/qtdeclarative:6
	dev-qt/qtsvg:6
	dev-qt/qtwebengine:6[widgets]
	epwing? ( dev-libs/eb )
	ffmpeg? (
		media-video/ffmpeg:*
	)
	!ffmpeg? ( dev-qt/qtmultimedia:6[gstreamer] )
	media-libs/libvorbis
	tts? ( dev-qt/qtspeech:6 )
	sys-libs/zlib
	systemfmt? ( dev-libs/libfmt )
	systemtoml? ( dev-cpp/tomlplusplus )
	virtual/opengl
	virtual/libiconv
	x11-libs/libX11
	x11-libs/libxkbcommon
	x11-libs/libXtst
	zim? ( app-arch/libzim )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/qttools:6[assistant,linguist]
	dev-vcs/git
	virtual/pkgconfig
"

src_prepare() {
	local loc_dir="${S}/locale"
	plocale_find_changes "${loc_dir}" "" ".ts"
	rm_loc() {
		rm -vf "locale/${1}.ts" || die
	}
	plocale_for_each_disabled_locale rm_loc

	cmake_src_prepare
}

src_configure() {
	# stack overfow & std::bad_alloc on musl
	use elibc_musl && append-ldflags -Wl,-z,stack-size=2097152

	local mycmakeargs=(
		-DWITH_FFMPEG_PLAYER=$(usex ffmpeg ON OFF)
		-DWITH_EPWING_SUPPORT=$(usex epwing ON OFF)
		-DUSE_SYSTEM_FMT=$(usex systemfmt ON OFF)
		-DUSE_SYSTEM_TOML=$(usex systemtoml ON OFF)
		-DWITH_TTS=$(usex tts ON OFF)
		-DWITH_ZIM=$(usex zim ON OFF)
		-DWITH_VCPKG_BREAKPAD=OFF
	)
	cmake_src_configure
}
