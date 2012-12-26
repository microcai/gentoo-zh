# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib cmake-utils eutils

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://fcitx.googlecode.com/files/${P}_dict.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE="+32bit +cairo debug gtk gtk3 icu introspection lua opencc +pango qt4 snooper static-libs +table test +xml"
RESTRICT="mirror"

RDEPEND="sys-apps/dbus
	x11-libs/libX11
	cairo? (
		x11-libs/cairo[X]
		pango? ( x11-libs/pango[X] )
		!pango? ( media-libs/fontconfig )
	)
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
	icu? ( dev-libs/icu )
	introspection? ( dev-libs/gobject-introspection )
	lua? ( dev-lang/lua )
	opencc? ( app-i18n/opencc )
	qt4? (
		x11-libs/qt-gui:4
		x11-libs/qt-dbus:4
	)
	xml? (
		app-text/iso-codes
		dev-libs/libxml2
		x11-libs/libxkbfile
	)
	x11-libs/libxkbfile[multilib=]
	multilib? (
		32bit? (
			gtk? (  app-emulation/emul-linux-x86-gtklibs )
			gtk3? (  app-emulation/emul-linux-x86-gtklibs )
			qt4? ( app-emulation/emul-linux-x86-qtlibs )
		)
	)
	"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	app-text/enchant
	dev-util/intltool
	virtual/pkgconfig
	x11-proto/xproto"

update_gtk_immodules() {
	local GTK2_CONFDIR="/etc/gtk-2.0"
	# bug #366889
	if has_version '>=x11-libs/gtk+-2.22.1-r1:2' || has_multilib_profile ; then
		GTK2_CONFDIR="${GTK2_CONFDIR}/$(get_abi_CHOST)"
	fi
	mkdir -p "${EPREFIX}${GTK2_CONFDIR}"

	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0" > "${EPREFIX}${GTK2_CONFDIR}/gtk.immodules"
	fi
	( if use multilib && use 32bit ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0-32" > ${EPREFIX}/etc/gtk-2.0/i686-pc-linux-gnu/gtk.immodules
	fi )
}

update_gtk3_immodules() {
	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-3.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-3.0" --update-cache
	fi
}

src_configure() {
	local mycmakeargs="
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
		$(cmake-utils_use_enable cairo CARIO)
		$(cmake-utils_use_enable debug DEBUG)
		$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
		$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
		$(cmake-utils_use_enable icu ICU)
		$(cmake-utils_use_enable introspection GIR)
		$(cmake-utils_use_enable lua LUA)
		$(cmake-utils_use_enable opencc OPENCC)
		$(cmake-utils_use_enable pango PANGO)
		$(cmake-utils_use_enable qt4 QT_IM_MODULE)
		$(cmake-utils_use_enable snooper SNOOPER)
		$(cmake-utils_use_enable static-libs STATIC)
		$(cmake-utils_use_enable table TABLE)
		$(cmake-utils_use_enable test TEST)
		$(cmake-utils_use_enable xml LIBXML2)"

		cmake-utils_src_configure

	( if use multilib && use 32bit ; then
		mkdir -p "${WORKDIR}/${P}_build32"
		cd "${WORKDIR}/${P}_build32"

	
		CFLAGS="$CFLAGS -m32"
		CXXFLAGS="$CXXFLAGS -m32"
		LDFLAGS="$LDFLAGS -m32 -L/usr/lib32/qt4"

		local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX=${D}/usr
			-DLIB_INSTALL_DIR=${D}/usr/lib32
			$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
			$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
			$(cmake-utils_use_enable qt4 QT_IM_MODULE)
			$(cmake-utils_use_enable debug DEBUG)
			$(cmake-utils_use_enable cairo CARIO)
			$(cmake-utils_use_enable pango PANGO)
			-DENABLE_GIR=OFF
			-DENABLE_TABLE=OFF
			-DENABLE_LIBXML2=OFF
			-DENABLE_STATIC=OFF
			-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
		)
		
		"${CMAKE_BINARY}" "${mycmakeargs[@]}" "${CMAKE_USE_DIR}" || die
	fi )
}

src_compile(){
	cmake-utils_src_compile

	if use multilib && use 32bit ; then
		cd ${WORKDIR}/${P}_build32/src/
		make -C lib

		use gtk  && 	emake -C frontend/gtk2
		use gtk3  && 	emake -C frontend/gtk3
		
		if use qt4 ; then
			make -C frontend/qt || ( 
				cd frontend/qt && 	c++ -m32 -shared -Wl,-soname,libqtim-fcitx.so -o libqtim-fcitx.so  CMakeFiles/qtim-fcitx.dir/*.o   -Wl,-z,defs -L/usr/lib32/qt4 -lQtCore -lQtDBus -lQtGui ../../lib/fcitx-utils/libfcitx-utils.so.0.1  -lX11 ../../lib/fcitx-config/libfcitx-config.so.4
			)
		fi		
	fi
}

src_install() {

	if use multilib && use 32bit ; then
		
		pushd "${WORKDIR}/${P}_build32/src"
		einstall -C lib
		
		cd  "frontend" || die
		use gtk && 	dodir /usr/lib32/gtk-2.0/2.10.0/immodules/
		use gtk3 &&	dodir /usr/lib32/gtk-3.0/3.0.0/immodules/
		use qt4 && dodir /usr/lib32/qt4/plugins/inputmethods/
		
		use gtk  && 	install gtk2/im-fcitx.so  "${D}/usr/lib32/gtk-2.0/2.10.0/immodules/"
		use gtk3  && 	install gtk3/im-fcitx.so   "${D}/usr/lib32/gtk-3.0/3.0.0/immodules/"
		use qt4  && 	install qt/libqtim-fcitx.so  "${D}/usr/lib32/qt4/plugins/inputmethods/"

		popd
	fi

	cmake-utils_src_install

	dodoc AUTHORS ChangeLog README THANKS TODO || die

	rm -rf "${ED}"/usr/share/doc/${PN} || die
	dodoc AUTHORS ChangeLog README THANKS TODO doc/pinyin.txt doc/cjkvinput.txt
	dohtml doc/wb_fh.htm

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
	use gtk && update_gtk_immodules
	use gtk3 && update_gtk3_immodules
	elog
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog
}

pkg_postrm() {
	use gtk && update_gtk_immodules
	use gtk3 && update_gtk3_immodules
}
