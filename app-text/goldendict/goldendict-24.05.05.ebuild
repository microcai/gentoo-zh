# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PLOCALES="ar_SA ay_BO be_BY bg_BG crowdin cs_CZ de_CH de_DE el_GR eo_UY es_AR es_BO es_ES fa_IR fi_FI fr_FR hi_IN ie_001 it_IT ja_JP jbo_EN ko_KR lt_LT mk_MK nl_NL pl_PL pt_BR pt_PT qt_extra_es qt_extra_it qt_extra_lt qtwebengine_zh_CN qu_PE ru_RU sk_SK sq_AL sr_SP sv_SE tg_TJ tk_TM tr_TR uk_UA vi_VN zh_CN zh_TW"

inherit desktop qmake-utils flag-o-matic xdg-utils plocale

MY_PV="24.05.05-LiXia.ecd1138c"

DESCRIPTION="Feature-rich dictionary lookup program (qtwebengine fork)"
HOMEPAGE="https://xiaoyifang.github.io/goldendict-ng/"
SRC_URI="https://github.com/xiaoyifang/goldendict-ng/archive/v${MY_PV}.tar.gz"

S="${WORKDIR}/goldendict-ng-${MY_PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug ffmpeg opencc multimedia wayland xapian zim"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	virtual/libiconv
	>=app-text/hunspell-1.2:=
	dev-libs/eb
	dev-libs/lzo
	dev-qt/qtbase:6[X,concurrent,gui,network,sql,widgets,xml]
	dev-qt/qtmultimedia:6
	dev-qt/qtspeech:6
	dev-qt/qtsvg:6
	dev-qt/qtwebengine:6[widgets]
	dev-qt/qtdeclarative:6
	dev-qt/qt5compat:6
	media-libs/libvorbis
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXtst
	virtual/opengl
	ffmpeg? (
		media-libs/libao
		media-video/ffmpeg:0=
	)
	opencc? ( app-i18n/opencc )
	multimedia? ( dev-qt/qtmultimedia[gstreamer] )
	xapian? ( dev-libs/xapian )
	zim? ( app-arch/libzim )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6[assistant,linguist]
	virtual/pkgconfig
"

src_prepare() {
	default

	use wayland && eapply "${FILESDIR}/remove-X11.patch"

	# disable git
	sed -i -e '/git describe/s/^/#/' ${PN}.pro || die

	# fix flags
	echo "QMAKE_CXXFLAGS_RELEASE = ${CFLAGS}" >> goldendict.pro
	echo "QMAKE_CFLAGS_RELEASE = ${CXXFLAGS}" >> goldendict.pro

	local loc_dir="${S}/locale"
	plocale_find_changes "${loc_dir}" "" ".ts"
	rm_loc() {
		rm -vf "locale/${1}.ts" || die
		sed -i "/${1}.ts/d" ${PN}.pro || die
	}
	plocale_for_each_disabled_locale rm_loc
}

src_configure() {
	local myconf=( CONFIG+=use_iconv CONFIG+=release )
	use opencc && myconf+=( CONFIG+=chinese_conversion_support )
	use ffmpeg || myconf+=( CONFIG+=no_ffmpeg_player )
	use multimedia || myconf+=( CONFIG+=no_qtmultimedia_player )
	use xapian && myconf+=( CONFIG+=use_xapian )
	use zim && myconf+=( CONFIG+=zim_support )

	# stack overfow & std::bad_alloc on musl
	use elibc_musl && append-ldflags -Wl,-z,stack-size=2097152

	eqmake6 "${myconf[@]}" PREFIX="/usr" goldendict.pro
}

src_install() {
	dobin ${PN}
	domenu redist/io.github.xiaoyifang.goldendict_ng.desktop
	doicon redist/icons/${PN}.png

	insinto /usr/share/${PN}/locale
	doins .qm/*.qm
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
