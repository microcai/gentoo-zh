# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils gnome2-utils fdo-mime multilib readme.gentoo

DESCRIPTION="Flexible Context-aware Input Tool with eXtension"
HOMEPAGE="http://fcitx-im.org/"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/fcitx/fcitx.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://download.fcitx-im.org/fcitx/${P}_dict.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+X +autostart +cairo +dbus debug +enchant gtk gtk3 icu introspection
	lua nls opencc +pango qt4 static-libs +table test +xml"

REQUIRED_USE="cairo? ( X ) gtk? ( X ) gtk3? ( X ) qt4? ( X )"

RDEPEND="
	X? (
		x11-libs/libX11
		x11-libs/libXinerama
	)
	cairo? (
		x11-libs/cairo[X]
		pango? ( x11-libs/pango[X] )
		!pango? ( media-libs/fontconfig )
	)
	dbus? ( sys-apps/dbus )
	enchant? ( app-text/enchant )
	gtk? (
		x11-libs/gtk+:2
		dev-libs/glib:2
		dev-libs/dbus-glib
	)
	gtk3? (
		x11-libs/gtk+:3
		dev-libs/glib:2
		dev-libs/dbus-glib
	)
	icu? ( dev-libs/icu:= )
	introspection? ( dev-libs/gobject-introspection )
	lua? ( dev-lang/lua )
	opencc? ( app-i18n/opencc )
	qt4? (
		dev-qt/qtgui:4[dbus(+),glib]
		dev-qt/qtdbus:4
	)
	xml? (
		app-text/iso-codes
		dev-libs/libxml2
		x11-libs/libxkbfile
	)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/libintl
	virtual/pkgconfig"

DOCS=(
	AUTHORS
	ChangeLog
	README
	THANKS
	TODO
	doc/pinyin.txt
	doc/cjkvinput.txt
	doc/API.txt
	doc/Develop_Readme
)
HTML_DOCS=(
	doc/wb_fh.htm
)

src_configure() {
	local mycmakeargs="
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
		-DSYSCONFDIR=/etc
		$(cmake-utils_use_enable X X11)
		$(cmake-utils_use_enable autostart XDGAUTOSTART)
		$(cmake-utils_use_enable cairo CAIRO)
		$(cmake-utils_use_enable dbus DBUS)
		$(cmake-utils_use_enable debug DEBUG)
		$(cmake-utils_use_enable enchant ENCHANT)
		$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
		$(cmake-utils_use_enable gtk SNOOPER)
		$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
		$(cmake-utils_use_enable gtk3 SNOOPER)
		$(cmake-utils_use_enable icu ICU)
		$(cmake-utils_use_enable introspection GIR)
		$(cmake-utils_use_enable lua LUA)
		$(cmake-utils_use_enable nls GETTEXT)
		$(cmake-utils_use_enable opencc OPENCC)
		$(cmake-utils_use_enable pango PANGO)
		$(cmake-utils_use_enable qt4 QT)
		$(cmake-utils_use_enable qt4 QT_IM_MODULE)
		$(cmake-utils_use_enable qt4 QT_GUI)
		$(cmake-utils_use_enable static-libs STATIC)
		$(cmake-utils_use_enable table TABLE)
		$(cmake-utils_use_enable test TEST)
		$(cmake-utils_use_enable xml LIBXML2)"

	if use gtk || use gtk3 || use qt4 ; then
		mycmakeargs+=" -DENABLE_GLIB2=ON "
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	rm -rf "${ED}"/usr/share/doc/${PN} || die
	use autostart && readme.gentoo_create_doc

	dodir /etc/X11/xinit/xinitrc.d/

	XINITRCFCITX="${D}/etc/X11/xinit/xinitrc.d/01-input"

	# fix firefox issue
	echo '#!/bin/bash' > "${XINITRCFCITX}"

	# echo XIM
	echo ''                              >> "${XINITRCFCITX}"
	echo 'export XMODIFIERS="@im=fcitx"' >> "${XINITRCFCITX}"
	echo 'export XIM=fcitx'              >> "${XINITRCFCITX}"
	echo 'export XIM_PROGRAM=fcitx'      >> "${XINITRCFCITX}"

	#echo gtk module
	if use gtk && use gtk3 ; then
		echo "export GTK_IM_MODULE=fcitx" >> "${XINITRCFCITX}"
	fi

	if use qt4 ; then
		echo "export QT_IM_MODULE=fcitx" >> "${XINITRCFCITX}"
	fi

	chmod 0755 "${XINITRCFCITX}"
}

pkg_postinst() {
	gnome2_icon_cache_update

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
	use autostart && readme.gentoo_pkg_postinst

	if ! use gtk || ! use gtk3 || ! use qt4; then
		ewarn "You haven't built any im modules."
		ewarn "It's highly recommended to use im module instead of XIM,"
		ewarn "in order to avoid unresolvable problem."
		ewarn
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}
