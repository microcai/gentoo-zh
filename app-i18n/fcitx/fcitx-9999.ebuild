# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib multilib-build cmake-utils eutils gnome2-utils fdo-mime

if [[ ${PV} == "9999" ]]; then
	inherit git-2
fi

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/fcitx/fcitx.git"
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
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+autostart +cairo +dbus debug +glib +gtk +gtk3 +icu +introspection lua
+pango +qt4 +snooper static-libs +table test +X +xml"

RDEPEND="
	cairo? (
		x11-libs/cairo[X]
		pango? ( x11-libs/pango[X] )
		!pango? ( media-libs/fontconfig )
	)
	dbus? ( sys-apps/dbus )
	glib? ( dev-libs/glib:2 )
	gtk? (
		x11-libs/gtk+:2
		dev-libs/dbus-glib
	)
	gtk3? (
		x11-libs/gtk+:3
		dev-libs/dbus-glib
	)
	icu? ( dev-libs/icu )
	lua? ( dev-lang/lua )
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4
	)
	X? (
		x11-libs/libX11[abi_x86_32=]
		x11-libs/libXinerama[abi_x86_32=]
	)
	xml? (
		app-text/iso-codes
		dev-libs/libxml2
		x11-libs/libxkbfile
	)
	amd64? ( abi_x86_32? (
		x11-libs/libxkbfile[multilib]
		gtk? ( app-emulation/emul-linux-x86-gtklibs )
		gtk3? ( app-emulation/emul-linux-x86-gtklibs )
		qt4? ( app-emulation/emul-linux-x86-qtlibs )
	) )"
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

update_gtk2_immodules() {
	gnome2_query_immodules_gtk2

	if use abi_x86_32 ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0-32" > ${EPREFIX}/etc/gtk-2.0/i686-pc-linux-gnu/gtk.immodules
	fi
}

#src_prepare() {
	# patch fcitx to let fcitx-sunpinyin to build with gcc 4.6
#	epatch "${FILESDIR}/${P}-gcc46-compatible.patch"
#}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
		-DFORCE_OPENCC=ON
		-DFORCE_ENCHANT=ON
		-DFORCE_PRESAGE=ON
		-DENABLE_BACKTRACE=ON
		-DENABLE_GETTEXT=ON
		$(cmake-utils_use_enable autostart XDGAUTOSTART)
		$(cmake-utils_use_enable cairo CAIRO)
		$(cmake-utils_use_enable dbus DBUS)
		$(cmake-utils_use_enable debug DEBUG)
		$(cmake-utils_use_enable glib GLIB2)
		$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
		$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
		$(cmake-utils_use_enable icu ICU)
		$(cmake-utils_use_enable introspection GIR)
		$(cmake-utils_use_enable lua LUA)
		$(cmake-utils_use_enable pango PANGO)
		$(cmake-utils_use_enable qt4 QT)
		$(cmake-utils_use_enable qt4 QT_IM_MODULE)
		$(cmake-utils_use_enable snooper SNOOPER)
		$(cmake-utils_use_enable static-libs STATIC)
		$(cmake-utils_use_enable table TABLE)
		$(cmake-utils_use_enable test TEST)
		$(cmake-utils_use_enable X X11)
		$(cmake-utils_use_enable xml LIBXML2)
	)

	cmake-utils_src_configure

	if use amd64 && use abi_x86_32 ; then
		mkdir -p "${WORKDIR}/${P}_build32"
		cd "${WORKDIR}/${P}_build32"

		local CFLAGS="$CFLAGS -m32"
		local CXXFLAGS="$CXXFLAGS -m32"
		local LDFLAGS="$LDFLAGS -m32 -L/usr/lib32/qt4"

		local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX=/usr
			-DLIB_INSTALL_DIR=/usr/lib32
			-DENABLE_OPENCC=OFF
			-DENABLE_ENCHANT=OFF
			-DENABLE_PRESAGE=OFF
			-DENABLE_CARIO=OFF
			-DENABLE_PANGO=OFF
			-DENABLE_ICU=OFF
			-DENABLE_GIR=OFF
			-DENABLE_TABLE=OFF
			-DENABLE_LIBXML2=OFF
			-DENABLE_STATIC=OFF
			$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
			$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
			$(cmake-utils_use_enable qt4 QT)
			$(cmake-utils_use_enable qt4 QT_IM_MODULE)
			$(cmake-utils_use_enable debug DEBUG)
			-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
		)

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

	if use amd64 && use abi_x86_32 ; then
		cd ${WORKDIR}/${P}_build32/src/
		emake -C lib || die

		use gtk && emake -C frontend/gtk2 || die
		use gtk3 && emake -C frontend/gtk3 || die
		use qt4 && emake -C frontend/qt || die
	fi
}

src_install() {
	if use amd64 && use abi_x86_32 ; then
		pushd "${WORKDIR}/${P}_build32/src"
		emake DESTDIR="${D}" -C lib install || die

		use gtk  && emake DESTDIR="${D}" -C frontend/gtk2 install || die
		use gtk3  && emake DESTDIR="${D}" -C frontend/gtk3 install || die
		use qt4  && emake DESTDIR="${D}" -C frontend/qt install || die

		popd
	fi
	rm -rf "${D}/usr/include" "${D}/usr/lib32/pkgconfig"

	cmake-utils_src_install

	# Remove the doc install by fcitx, We will install it manually.
	rm -rf "${ED}"/usr/share/doc/${PN} || die

	dodir /etc/X11/xinit/xinitrc.d/

	XINITRCFCITX="${D}/etc/X11/xinit/xinitrc.d/01-input"

	# fix firefox issue
	echo "#! /bin/bash"  > "${XINITRCFCITX}"

	# echo XIM
	echo "export XMODIFIERS=\"@im=fcitx\""  >> "${XINITRCFCITX}"
	echo "export XIM=fcitx" >> "${XINITRCFCITX}"
	echo "export XIM_PROGRAM=fcitx" >> "${XINITRCFCITX}"

	#echo gtk module
	if use gtk || use gtk3 ; then
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
	use gtk && update_gtk2_immodules
	use gtk3 && gnome2_query_immodules_gtk3

	elog
	elog "You should at least install one of app-i18n/kcm-fcitx or"
	elog "app-i18n/fcitx-configtool to have a GUI config tool for fcitx."
	elog "Otherwise, you will have to manually edit the conf file."
	elog

	if use autostart; then
		elog "You have enabled the autostart USE flag."
		elog "It works if you are running a XDG compatible desktop, such as"
		elog "Gnome, KDE, LXDE, Xfce, etc."
		elog "If you ~/.xinitrc, you have to put fcitx to your ~/.xinitrc to"
		elog "start it."
		elog
	fi

	if ! use gtk || ! use gtk3 || !use qt4; then
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
	use gtk && update_gtk2_immodules
	use gtk3 && gnome2_query_immodules_gtk3
}

