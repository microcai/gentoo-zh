# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils xdg-utils git-r3
EGIT_REPO_URI="https://github.com/fcitx/fcitx5.git"

KEYWORDS="~amd64 ~x86"
if [[ "${PV}" == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
fi

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/fcitx"
SRC_URI="https://download.fcitx-im.org/data/en_dict-20121020.tar.gz -> fcitx-data-en_dict-20121020.tar.gz"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE="+enchant test coverage doc presage systemd wayland"
REQUIRED_USE="coverage? ( test )"
RDEPEND="dev-libs/glib:2
	sys-apps/dbus
	dev-libs/json-c
	dev-libs/libfmt
	sys-apps/util-linux
	virtual/libiconv
	virtual/libintl
	x11-libs/libxkbcommon[X]
	x11-libs/libX11
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
	)
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
	enchant? ( app-text/enchant:= )
	systemd? ( sys-apps/systemd )
	app-text/iso-codes
	app-i18n/unicode-cldr
	dev-libs/libxml2
	dev-libs/libevent"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	pwd
	ln -s "${DISTDIR}/fcitx-data-en_dict-20121020.tar.gz" src/modules/spell/dict/en_dict-20121020.tar.gz || die

	cmake_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
		-DENABLE_ENCHANT=$(usex enchant)
		-DENABLE_PRESAGE=$(usex presage)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_DOC=$(usex doc)
		-DUSE_SYSTEMD=$(usex systemd)
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	elog
	elog "Follow the instrcutions of https://wiki.gentoo.org/wiki/Fcitx#Using_Fcitx"
	elog "and change the fcitx to fcitx5"
	elog
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
