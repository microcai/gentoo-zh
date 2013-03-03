# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit confutils qt4-build

DESCRIPTION="The GUI module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="+accessibility cups dbus egl gif +glib gtkstyle mng nas nis qt3support
tiff trace xinerama qpa"

RDEPEND="
	app-admin/eselect-qtgraphicssystem
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libpng:0
	sys-libs/zlib
	virtual/jpeg
	~dev-qt/qtcore-${PV}[aqua=,c++0x=,qpa=,debug=,glib=,qt3support=]
	~dev-qt/qtscript-${PV}[aqua=,c++0x=,qpa=,debug=]
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
	dbus? ( ~dev-qt/qtdbus-${PV}[aqua=,c++0x=,qpa=,debug=] )
	gtkstyle? ( x11-libs/gtk+:2[aqua=] )
	mng? ( >=media-libs/libmng-1.0.9 )
	nas? ( >=media-libs/nas-1.5 )
	tiff? ( media-libs/tiff:0 )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	!aqua? (
		x11-proto/xextproto
		x11-proto/inputproto
	)
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${RDEPEND}
	!~x11-themes/qgtkstyle-4.7.2"
PDEPEND="qt3support? ( ~dev-qt/qtqt3support-${PV}[aqua=,c++0x=,qpa=,debug=] )"

PATCHES=(
"${FILESDIR}/add-missing-style-scsi-4_8_0.diff"
"${FILESDIR}/synthetic-bold-4_8_0.diff"
)

pkg_setup() {
	# this belongs to pkg_pretend, we have to upgrade to EAPI 4 :)
	# was planning to use a dep, but to reproduce this you have to
	# clean-emerge qt-gui[gtkstyle] while having cairo[qt4] installed.
	# no need to restrict normal first time users for that :)
	if use gtkstyle && ! has_version dev-qt/qtgui && has_version x11-libs/cairo[qt4]; then
		echo
		eerror "When building qt-gui[gtkstyle] from scratch with cairo present,"
		eerror "cairo must have the qt4 use flag disabled, otherwise the gtk"
		eerror "style cannot be built."
		ewarn
		eerror "You have the following options:"
		eerror "  - rebuild cairo with -qt4 USE"
		eerror "  - build qt-gui with -gtkstyle USE"
		ewarn
		eerror "After you successfully install qt-gui, you'll be able to"
		eerror "re-enable the disabled use flag and/or reinstall cairo."
		ewarn
		echo
		die "can't build qt-gui with gtkstyle USE if cairo has qt4 USE enabled"
	fi

	confutils_use_depend_all gtkstyle glib

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
		tools"

	use dbus && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} tools/qdbus/qdbusviewer"
	use mng && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/imageformats/mng"
	use tiff && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/imageformats/tiff"
	use accessibility && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/accessible/widgets"
	use trace && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES}	src/plugins/graphicssystems/trace"

	QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES} ${QT4_EXTRACT_DIRECTORIES}"

	# mac version does not contain qtconfig?
	[[ ${CHOST} == *-darwin* ]] || QT4_TARGET_DIRECTORIES+=" tools/qtconfig"

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
		$(qt_use gtkstyle)
		$(qt_use xinerama)"

	use gif || myconf="${myconf} -no-gif"
	use nas	&& myconf="${myconf} -system-nas-sound"

	[[ x86_64-apple-darwin* ]] && myconf="${myconf} -no-ssse3" #367045

	myconf="${myconf} -system-libpng -system-libjpeg
		-no-sql-mysql -no-sql-psql -no-sql-ibase -no-sql-sqlite -no-sql-sqlite2
		-no-sql-odbc -xrender -xrandr -xkb -xshape -sm -no-svg -no-webkit
		-no-phonon -no-opengl"

	qt4-build_src_configure

	if use gtkstyle; then
		einfo "patching the Makefile to fix qgtkstyle compilation"
		sed "s:-I/usr/include/qt4 ::" -i src/gui/Makefile ||
			die "sed failed"
	fi
	einfo "patching the Makefile to fix bug #361277"
	sed "s:-I/usr/include/qt4/QtGui ::" -i src/gui/Makefile ||
		die "sed failed"
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

	# touch the available graphics systems
	mkdir -p "${D}/usr/share/qt4/graphicssystems/" ||
		die "could not create ${D}/usr/share/qt4/graphicssystems/"
	echo "default" > "${D}/usr/share/qt4/graphicssystems/raster" ||
		die "could not touch ${D}/usr/share/qt4/graphicssystems/raster"
	touch "${D}/usr/share/qt4/graphicssystems/native" ||
		die "could not touch ${D}/usr/share/qt4/graphicssystems/native"

	# install private headers
	if use aqua && [[ ${CHOST##*-darwin} -ge 9 ]] ; then
		insinto "${QTLIBDIR#${EPREFIX}}"/QtGui.framework/Headers/private/
	else
		insinto "${QTHEADERDIR#${EPREFIX}}"/QtGui/private
	fi
	find "${S}"/src/gui -type f -name "*_p.h" -exec doins {} \;

	if use aqua && [[ ${CHOST##*-darwin} -ge 9 ]] ; then
		# rerun to get links to headers right
		fix_includes
	fi

	# install correct designer and linguist icons, bug 241208
	doicon tools/linguist/linguist/images/icons/linguist-128-32.png \
		tools/designer/src/designer/images/designer.png \
		|| die "doicon failed"
	# Note: absolute image path required here!
	make_desktop_entry linguist Linguist \
			"${EPREFIX}"/usr/share/pixmaps/linguist-128-32.png \
			'Qt;Development;GUIDesigner' \
			|| die "linguist make_desktop_entry failed"
	make_desktop_entry designer Designer \
			"${EPREFIX}"/usr/share/pixmaps/designer.png \
			'Qt;Development;GUIDesigner' \
			|| die "designer make_desktop_entry failed"
}

pkg_postinst() {
	# raster is the default graphicssystems, set it if first install
	eselect qtgraphicssystem set raster --use-old
	elog "Starting with Qt 4.8.0, you may choose the active Qt Graphics System"
	elog "by using a new eselect module called qtgraphicssystem."
	elog "Run"
	elog "  eselect qtgraphicssystem"
	elog "for more information"
}
