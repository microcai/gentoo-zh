# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit confutils qt4-build

DESCRIPTION="The GUI module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="+accessibility cups dbus egl +glib mng nas nis private-headers qt3support raster tiff trace xinerama"

RDEPEND="media-libs/fontconfig
	media-libs/freetype:2
	virtual/jpeg
	media-libs/libpng
	sys-libs/zlib
	~dev-qt/qtcore-${PV}[aqua=,debug=,glib=,qt3support=]
	~dev-qt/qtscript-${PV}[aqua=,debug=]
	!aqua? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libXcursor
		x11-libs/libXfont
		x11-libs/libSM
		x11-libs/libXi
	)
	cups? ( net-print/cups )
	dbus? ( ~dev-qt/qtdbus-${PV}[aqua=,debug=] )
	mng? ( >=media-libs/libmng-1.0.9 )
	nas? ( >=media-libs/nas-1.5 )
	tiff? ( media-libs/tiff )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	!aqua? (
		x11-proto/xextproto
		x11-proto/inputproto
	)
	xinerama? ( x11-proto/xineramaproto )"
PDEPEND="qt3support? ( ~dev-qt/qtqt3support-${PV}[aqua=,debug=] )"

# "${FILESDIR}/add-missing-style-scsi-4_7_1.diff"
# "${FILESDIR}/synthetic-bold-4_7_1.diff"
PATCHES=( "${FILESDIR}/add-missing-style-scsi-4_7_1.diff" )
pkg_setup() {
	echo
	einfo "Qt's GTK style was moved to x11-themes/qgtkstyle to fix bug #336801"
	echo

	if ! use qt3support; then
		ewarn "WARNING: if you need 'qtconfig', you _must_ enable qt3support."
	fi

	QT4_TARGET_DIRECTORIES="
		src/gui
		src/scripttools
		tools/designer
		tools/linguist/linguist
		src/plugins/imageformats/gif
		src/plugins/imageformats/ico
		src/plugins/imageformats/jpeg
		src/plugins/inputmethods"

	QT4_EXTRACT_DIRECTORIES="
		include
		src
		tools/linguist/phrasebooks
		tools/linguist/shared
		tools/shared"

	use dbus && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} tools/qdbus/qdbusviewer"
	use mng && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/imageformats/mng"
	use tiff && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/imageformats/tiff"
	use accessibility && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/accessible/widgets"
	use trace && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES}	src/plugins/graphicssystems/trace"

	QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES} ${QT4_EXTRACT_DIRECTORIES}"

	qt4-build_pkg_setup
}

src_prepare() {
	qt4-build_src_prepare

	# Don't build plugins this go around, because they depend on qt3support lib
	sed -i -e "s:CONFIG(shared:# &:g" "${S}"/tools/designer/src/src.pro
}

src_configure() {
	export PATH="${S}/bin:${PATH}"
	export LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"

	myconf="$(qt_use accessibility)
		$(qt_use cups)
		$(qt_use glib)
		$(qt_use mng libmng system)
		$(qt_use nis)
		$(qt_use tiff libtiff system)
		$(qt_use dbus qdbus)
		$(qt_use dbus)
		$(qt_use egl)
		$(qt_use qt3support)
		$(qt_use xinerama)"

	use nas	&& myconf="${myconf} -system-nas-sound"
	use raster && myconf="${myconf} -graphicssystem raster"

	myconf="${myconf} -qt-gif -system-libpng -system-libjpeg
		-no-sql-mysql -no-sql-psql -no-sql-ibase -no-sql-sqlite -no-sql-sqlite2
		-no-sql-odbc -xrender -xrandr -xkb -xshape -sm -no-svg -no-webkit
		-no-phonon -no-opengl -no-gtkstyle"

	qt4-build_src_configure
}

src_install() {
	QCONFIG_ADD="x11sm xshape xcursor xfixes xrandr xrender xkb fontconfig
		$(usev accessibility) $(usev xinerama) $(usev cups) $(usev nas)
		gif png system-png system-jpeg
		$(use mng && echo system-mng)
		$(use tiff && echo system-tiff)"
	QCONFIG_REMOVE="no-gif no-png"
	QCONFIG_DEFINE="$(use accessibility && echo QT_ACCESSIBILITY)
			$(use cups && echo QT_CUPS) QT_FONTCONFIG QT_IMAGEFORMAT_JPEG
			$(use mng && echo QT_IMAGEFORMAT_MNG)
			$(use nas && echo QT_NAS)
			$(use nis && echo QT_NIS) QT_IMAGEFORMAT_PNG QT_SESSIONMANAGER QT_SHAPE
			$(use tiff && echo QT_IMAGEFORMAT_TIFF) QT_XCURSOR
			$(use xinerama && echo QT_XINERAMA) QT_XFIXES QT_XKB QT_XRANDR QT_XRENDER"

	qt4-build_src_install

	# remove unnecessary Windows headers
	rm -f "${D}${QTHEADERDIR}"/{Qt,QtGui}/qwindowdefs_win.h
	# remove Mac OS X headers
	use aqua || rm -f \
		"${D}${QTHEADERDIR}"/{Qt,QtGui}/qmacstyle_mac.h \
		"${D}${QTHEADERDIR}"/QtGui/QMacStyle

	# qt-creator
	# some qt-creator headers are located
	# under /usr/include/qt4/QtDesigner/private.
	# those headers are just includes of the headers
	# which are located under tools/designer/src/lib/*
	# So instead of installing both, we create the private folder
	# and drop tools/designer/src/lib/* headers in it.
	if use aqua && [[ ${CHOST##*-darwin} -ge 9 ]] ; then
		insinto "${QTLIBDIR#${EPREFIX}}"/QtDesigner.framework/Headers/private/
	else
		insinto "${QTHEADERDIR#${EPREFIX}}"/QtDesigner/private/
	fi
	doins "${S}"/tools/designer/src/lib/shared/* || die
	doins "${S}"/tools/designer/src/lib/sdk/* || die
	#install private headers
	if use private-headers; then
		if use aqua && [[ ${CHOST##*-darwin} -ge 9 ]] ; then
			insinto "${QTLIBDIR#${EPREFIX}}"/QtGui.framework/Headers/private/
		else
			insinto "${QTHEADERDIR#${EPREFIX}}"/QtGui/private
		fi
		find "${S}"/src/gui -type f -name "*_p.h" -exec doins {} \;
	fi
	if use aqua && [[ ${CHOST##*-darwin} -ge 9 ]] ; then
		# rerun to get links to headers right
		fix_includes
	fi

	# install correct designer and linguist icons, bug 241208
	doicon tools/linguist/linguist/images/icons/linguist-128-32.png \
		tools/designer/src/designer/images/designer.png \
		|| die "doicon failed"
	# Note: absolute image path required here!
	make_desktop_entry "${EPREFIX}"/usr/bin/linguist Linguist \
			"${EPREFIX}"/usr/share/pixmaps/linguist-128-32.png \
			'Qt;Development;GUIDesigner' \
			|| die "linguist make_desktop_entry failed"
	make_desktop_entry "${EPREFIX}"/usr/bin/designer Designer \
			"${EPREFIX}"/usr/share/pixmaps/designer.png \
			'Qt;Development;GUIDesigner' \
			|| die "designer make_desktop_entry failed"
}
