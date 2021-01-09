# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils git-r3 gnome2-utils xdg-utils
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-gtk.git"

SRC_URI=""

DESCRIPTION="Gtk im module for fcitx5 and glib based dbus client library"
HOMEPAGE="https://github.com/fcitx/fcitx5-gtk"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
KEYWORDS=""
IUSE="+gtk2 +gtk3 +introspection +snooper"

RDEPEND="app-i18n/fcitx5
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	introspection? ( dev-libs/gobject-introspection )
	kde-frameworks/extra-cmake-modules"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_GTK2_IM_MODULE=$(usex gtk2)
		-DENABLE_GTK3_IM_MODULE=$(usex gtk3)
		-DENABLE_GTK4_IM_MODULE=no
		-DENABLE_SNOOPER=$(usex snooper)
		-DENABLE_GIR=$(usex introspection)
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
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	use gtk2 && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}
