# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils gnome2-utils xdg-utils git-r3
EGIT_REPO_URI="https://gitlab.com/fcitx/fcitx5.git"

if [[ ! "${PV}" =~ (^|\.)9999$ ]]; then
	EGIT_COMMIT="7ccf3f6022deca8f7183066cf5cc8634a48671da"
fi
SRC_URI=""

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/fcitx"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
KEYWORDS="~amd64"
IUSE="+enchant test coverage doc presage qt4 qt5 gtk2 gtk3 systemd"
REQUIRED_USE="coverage? ( test )"

RDEPEND="dev-libs/glib:2
	sys-apps/dbus
	dev-libs/libfmt
	sys-apps/util-linux
	virtual/libiconv
	virtual/libintl
	x11-libs/libxkbcommon
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXinerama
	x11-libs/libXrender
	x11-libs/libxkbfile
	x11-libs/xcb-imdkit
	x11-misc/xkeyboard-config
	x11-libs/cairo[X]
	x11-libs/libXext
	x11-libs/pango
	media-libs/fontconfig
	enchant? ( app-text/enchant:0= )
	gtk2? ( app-i18n/fcitx5-gtk[gtk2] )
	gtk3? ( app-i18n/fcitx5-gtk[gtk3] )
	qt5?  ( app-i18n/fcitx5-qt[qt5] )
	qt4?  ( app-i18n/fcitx5-qt[qt4] )
	app-text/iso-codes
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

DOCS=(AUTHORS ChangeLog THANKS)

src_prepare() {
	cmake-utils_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DSYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
		-DENABLE_ENCHANT=$(usex enchant)
		-DENABLE_PRESAGE=$(usex presage)
		-DENABLE_DOC=$(usex doc)
		-DUSE_SYSTEMD=$(usex systemd)
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	use gtk2 && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3

	elog
	elog "Follow the instrcutions of https://wiki.gentoo.org/wiki/Fcitx#Using_Fcitx"
	elog "and change the fcitx to fcitx5"
	elog
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	use gtk2 && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}
