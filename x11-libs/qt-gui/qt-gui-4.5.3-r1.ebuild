# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-gui/qt-gui-4.5.3-r1.ebuild,v 1.1 2009/10/04 10:23:04 wired Exp $

EAPI="2"
inherit eutils qt4-build

DESCRIPTION="The GUI module for the Qt toolkit"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+accessibility cups dbus +glib gtk mng nas nis raster tiff qt3support xinerama"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXfont
	x11-libs/libSM
	x11-libs/libXi
	~x11-libs/qt-core-${PV}[debug=,glib=,qt3support=]
	~x11-libs/qt-script-${PV}[debug=]
	cups? ( net-print/cups )
	dbus? ( ~x11-libs/qt-dbus-${PV}[debug=] )
	gtk? ( x11-libs/gtk+:2 )
	mng? ( >=media-libs/libmng-1.0.9 )
	nas? ( >=media-libs/nas-1.5 )
	tiff? ( media-libs/tiff )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/xextproto
	x11-proto/inputproto"
PDEPEND="qt3support? ( ~x11-libs/qt-qt3support-${PV}[debug=] )"

QT4_TARGET_DIRECTORIES="
src/gui
src/scripttools/
tools/designer
tools/linguist/linguist
src/plugins/imageformats/gif
src/plugins/imageformats/ico
src/plugins/imageformats/jpeg
src/plugins/inputmethods"

QT4_EXTRACT_DIRECTORIES="
include/
src/
tools/linguist/shared
tools/linguist/phrasebooks
tools/shared/"

pkg_setup() {
	if use raster; then
		ewarn "WARNING: You have enabled raster backend rendering engine."
		ewarn "This is a new feature and may lead to composite problems"
		ewarn "screen corruption and broken qt4 or kde4 applications. "
		ewarn "If you encounter such problems please"
		ewarn "remove 'raster' use flag and re-compile qt-gui before"
		ewarn "filling a bug on gentoo bugzilla."
		ebeep 5
	fi
	qt4-build_pkg_setup
}

src_unpack() {
	use dbus && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} tools/qdbus/qdbusviewer"
	use mng && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/imageformats/mng"
	use tiff && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/imageformats/tiff"
	use accessibility && QT4_TARGET_DIRECTORIES="${QT4_TARGET_DIRECTORIES} src/plugins/accessible/widgets"
	QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES} ${QT4_EXTRACT_DIRECTORIES}"

	qt4-build_src_unpack
}

src_prepare() {
	qt4-build_src_prepare

	# Don't build plugins this go around, because they depend on qt3support lib
	sed -i -e "s:CONFIG(shared:# &:g" "${S}"/tools/designer/src/src.pro

	# fixing hardcoded fonts, bug #252312
	EPATCH_OPTS="--ignore-whitespace"
	epatch "${FILESDIR}"/hardcoded_fonts.patch
	
	#gentoo-tw
	epatch ${FILESDIR}/patch/text/add-missing-style-scsi.diff
	epatch ${FILESDIR}/patch/synthetic-bold-4.5.diff
		
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
		$(qt_use qt3support)
		$(qt_use gtk gtkstyle)
		$(qt_use xinerama)"

	use nas	&& myconf="${myconf} -system-nas-sound"
	use raster && myconf="${myconf} -graphicssystem raster"

	myconf="${myconf} -qt-gif -system-libpng -system-libjpeg
		-no-sql-mysql -no-sql-psql -no-sql-ibase -no-sql-sqlite -no-sql-sqlite2 -no-sql-odbc
		-xrender -xrandr -xkb -xshape -sm  -no-svg"

	# Explicitly don't compile these packages.
	# Emerge "qt-webkit", "qt-phonon", etc for their functionality.
	myconf="${myconf} -no-webkit -no-phonon -no-dbus -no-opengl"

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

	# remove some unnecessary headers
	rm -f "${D}${QTHEADERDIR}"/{Qt,QtGui}/{qmacstyle_mac.h,qwindowdefs_win.h} \
		"${D}${QTHEADERDIR}"/QtGui/QMacStyle

	# qt-creator
	# some qt-creator headers are located
	# under /usr/include/qt4/QtDesigner/private.
	# those headers are just includes of the headers
	# which are located under tools/designer/src/lib/*
	# So instead of installing both, we create the private folder
	# and drop tools/designer/src/lib/* headers in it.
	dodir /usr/include/qt4/QtDesigner/private/
	insinto /usr/include/qt4/QtDesigner/private/
	doins "${S}"/tools/designer/src/lib/shared/*
	doins "${S}"/tools/designer/src/lib/sdk/*

	# install correct designer and linguist icons, bug 241208
	doicon tools/linguist/linguist/images/icons/linguist-128-32.png \
		tools/designer/src/designer/images/designer.png \
		|| die "doicon failed"
	# Note: absolute image path required here!
	make_desktop_entry /usr/bin/linguist Linguist \
			/usr/share/pixmaps/linguist-128-32.png \
			'Qt;Development;GUIDesigner' \
			|| die "linguist make_desktop_entry failed"
	make_desktop_entry /usr/bin/designer Designer \
			/usr/share/pixmaps/designer.png \
			'Qt;Development;GUIDesigner' \
			|| die "designer make_desktop_entry failed"
}

pkg_postinst() {
	if use gtk ; then
		ewarn 'If you get the following error when setting Qt to use the GTK style:'
		ewarn '    "QGtkStyle cannot be used together with the GTK_Qt engine."'
		ewarn 'make sure you have GTK configured to NOT use the GTK_Qt engine and'
		ewarn 'export GTK2_RC_FILES="$HOME/.gtkrc-2.0" in your environment.'
	fi
	qt4-build_pkg_postinst
}
