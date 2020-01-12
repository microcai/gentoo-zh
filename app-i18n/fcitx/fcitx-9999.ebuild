# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib multilib-build cmake-utils eutils gnome2-utils fdo-mime

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
fi

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/fcitx/fcitx.git"
	SRC_URI="${HOMEPAGE}/files/pinyin.tar.gz
		table? ( ${HOMEPAGE}/files/table.tar.gz )"
else
	SRC_URI="http://fcitx.googlecode.com/files/${P}_dict.tar.xz"
	RESTRICT="mirror"
fi

DESCRIPTION="Flexible Context-aware Input Tool with eXtension"
HOMEPAGE="http://fcitx-im.org/wiki/Fcitx"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+autostart +cairo +dbus debug +glib +gtk +gtk3 +icu +introspection lua
+pango +qt4 +snooper static-libs +table test +X +xml"

RDEPEND=RDEPEND="
        X? (
                x11-libs/libX11[abi_x86_32?]
                x11-libs/libXinerama[abi_x86_32?]
        )
        cairo? (
                x11-libs/cairo[X]
                pango? ( x11-libs/pango[X] )
                !pango? ( media-libs/fontconfig )
        )
        dbus? ( sys-apps/dbus )
        enchant? ( app-text/enchant )
        gtk? (
                x11-libs/gtk+:2[abi_x86_32?]
                dev-libs/glib:2[abi_x86_32?]
                dev-libs/dbus-glib[abi_x86_32?]
        )
        gtk3? (
                x11-libs/gtk+:3[abi_x86_32?]
                dev-libs/glib:2[abi_x86_32?]
                dev-libs/dbus-glib[abi_x86_32?]
        )
        icu? ( dev-libs/icu:= )
        lua? ( dev-lang/lua )
        opencc? ( app-i18n/opencc )
        qt4? (
                dev-qt/qtgui:4[dbus(+),glib,abi_x86_32?]
                dev-qt/qtdbus:4[abi_x86_32?]
        )
        xml? (
                app-text/iso-codes
                dev-libs/libxml2[abi_x86_32?]
                x11-libs/libxkbfile
        )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	introspection? ( dev-libs/gobject-introspection )
	sys-devel/gettext
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

	if use abi_x86_64 && use abi_x86_32 ; then
		mkdir -p "${WORKDIR}/${P}_build32"
		cd "${WORKDIR}/${P}_build32"

		local CFLAGS="$CFLAGS -m32"
		local CXXFLAGS="$CXXFLAGS -m32"
		local LDFLAGS="$LDFLAGS -m32 -L/usr/lib32/qt4"

		local mycmakeargs="
			-DSYSCONFDIR=/etc
			-DLIB_INSTALL_DIR=/usr/lib32
			$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
			$(cmake-utils_use_enable gtk SNOOPER)
			$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
			$(cmake-utils_use_enable gtk3 SNOOPER)
			$(cmake-utils_use_enable qt4 QT)
			$(cmake-utils_use_enable qt4 QT_IM_MODULE)
			$(cmake-utils_use_enable qt4 QT_GUI)"

		"${CMAKE_BINARY}" "${mycmakeargs[@]}" "${CMAKE_USE_DIR}" || die

		sed -i "s|/usr/lib64/qt4|/usr/lib32/qt4|g" \
			`grep -rl /usr/lib64/qt4 ./src` || die
		sed -i "s|lib64|lib32|g" \
			src/frontend/gtk2/cmake_install.cmake \
			src/frontend/gtk3/cmake_install.cmake || die
	fi
}

src_compile(){
	cmake-utils_src_compile

	if use abi_x86_64 && use abi_x86_32 ; then
		cd ${WORKDIR}/${P}_build32/src/
		emake -C lib || die

		use gtk && emake -C frontend/gtk2 || die
		use gtk3 && emake -C frontend/gtk3 || die
		use qt4 && emake -C frontend/qt || die
	fi
}

src_install() {
        if use abi_x86_64 && use abi_x86_32 ; then
                pushd "${WORKDIR}/${P}_build32/src"
                emake DESTDIR="${D}" -C lib/fcitx-config install || die
                emake DESTDIR="${D}" -C lib/fcitx-utils install || die
                emake DESTDIR="${D}" -C lib/fcitx-gclient install || die
                use qt4  && emake DESTDIR="${D}" -C lib/fcitx-qt install || die

                use gtk  && emake DESTDIR="${D}" -C frontend/gtk2 install || die
                use gtk3  && emake DESTDIR="${D}" -C frontend/gtk3 install || die
                use qt4  && emake DESTDIR="${D}" -C frontend/qt install || die

                popd
        fi

        rm -rf "${D}/usr/include" "${D}/usr/lib32/pkgconfig"
        rm -rf "${D}/usr/local"

	cmake-utils_src_install
	rm -rf "${ED}"/usr/share/doc/${PN} || die
	use autostart && readme.gentoo_create_doc

	dodir /etc/X11/xinit/xinitrc.d/

	XINITRCFCITX="${D}/etc/X11/xinit/xinitrc.d/01-input"

	# fix firefox issue
	echo "#! /bin/bash"  > "${XINITRCFCITX}"

	# echo XIM
	echo "export XMODIFIERS=\"@im=fcitx\""  >> "${XINITRCFCITX}"
	echo "export XIM=fcitx" >> "${XINITRCFCITX}"
	echo "export XIM_PROGRAM=fcitx" >> "${XINITRCFCITX}"

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
		ewarn "You haven't built all im modules."
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
