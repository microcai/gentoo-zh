# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator

MY_VER="$(get_version_component_range 1-3)-1+git$(get_version_component_range 4)~610e2651de"

KEYWORDS="~amd64 ~x86"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/c/${PN}/${PN}_${MY_VER}.tar.gz"

inherit eutils cmake-utils gnome2-utils toolchain-funcs

DESCRIPTION="OpenGL compositing window manager."
HOMEPAGE="https://launchpad.net/compiz"
LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0.9"
IUSE="+cairo debug dbus fuse gnome gtk kde +svg test"

COMMONDEPEND="
	!x11-wm/compiz-fusion
	!x11-libs/compiz-bcop
	!x11-libs/libcompizconfig
	!x11-libs/compizconfig-backend-gconf
	!x11-libs/compizconfig-backend-kconfig4
	!x11-plugins/compiz-plugins-main
	!x11-plugins/compiz-plugins-extra
	!x11-plugins/compiz-plugins-unsupported
	!x11-apps/ccsm
	!dev-python/compizconfig-python
	!x11-apps/fusion-icon
	dev-libs/boost
	dev-libs/glib:2
	dev-cpp/glibmm
	dev-libs/libxml2
	dev-libs/libxslt
	dev-python/pyrex
	dev-libs/protobuf
	media-libs/libpng
	x11-base/xorg-server
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXinerama
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/startup-notification
	virtual/opengl
	virtual/glu
	cairo? ( x11-libs/cairo[X] )
	fuse? ( sys-fs/fuse )
	gtk? (
		>=x11-libs/gtk+-2.18.0
		>=x11-libs/libwnck-2.19.4
		x11-libs/pango
		gnome? (
			gnome-base/gnome-desktop
			gnome-base/gconf
			x11-wm/metacity
		)
	)
	kde? ( kde-base/kwin:4 )
	svg? (
		gnome-base/librsvg:2
		x11-libs/cairo
	)
	dbus? ( sys-apps/dbus )"

DEPEND="${COMMONDEPEND}
	app-admin/chrpath
	virtual/pkgconfig
	x11-proto/damageproto
	x11-proto/xineramaproto
	test? (
		dev-cpp/gtest
		dev-cpp/gmock
	)"

RDEPEND="${COMMONDEPEND}
	dev-python/pygtk
	x11-apps/mesa-progs
	x11-apps/xvinfo
	x11-themes/hicolor-icon-theme"

# TODO:
# - Remove automagic dependency for coverage report generation tools
# - Fix Xig-0 automagic resolving('CMake Warning at tests/integration/xig/CMakeLists.txt:30 (message): Xig not found, you will not be able to run X Server integration tests')
# - Check proper compilation with missing gettext/intltool
# - CFLAGS are NOT respected, this needs to be fixed
# - Default decorator exec command in ccsm is bad
# - Check all dependencies once more
# - Check CMakeFiles.txt this subdirectories :
# cmake - ?
# src
# compizconfig
# plugins
# tests - ?

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 6 ]] ) \
			&& die "Sorry, but gcc 4.6 or higher is required."
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.8.2-sandbox.patch"

	echo "gtk/gnome/compiz-wm.desktop.in" >> "${S}/po/POTFILES.skip"
	echo "metadata/core.xml.in" >> "${S}/po/POTFILES.skip"

	# Fix wrong path for icons
	sed -i 's:DataDir = "@prefix@/share":DataDir = "/usr/share":' compizconfig/ccsm/ccm/Constants.py.in

	default
}

src_configure() {
	local mycmakeargs=(
		"$(cmake-utils_use_use gnome GCONF)"
		"$(cmake-utils_use_use gnome GNOME)"
		"$(cmake-utils_use_use gnome GSETTINGS)"
		"$(cmake-utils_use_use gtk GTK)"
		"$(cmake-utils_use_use kde KDE4)"
		"$(cmake-utils_use test COMPIZ_BUILD_TESTING)"
		"-DCMAKE_INSTALL_PREFIX=/usr"
		"-DCMAKE_C_FLAGS=$(usex debug '-DDEBUG -ggdb' '')"
		"-DCMAKE_CXX_FLAGS=$(usex debug '-DDEBUG -ggdb' '')"
		"-DCOMPIZ_DEFAULT_PLUGINS=ccp composite"
		"-DCOMPIZ_DISABLE_SCHEMAS_INSTALL=OFF"
		"-DCOMPIZ_PACKAGING_ENABLED=ON"
	)
	cmake-utils_src_configure
}

src_install() {
	pushd "${CMAKE_BUILD_DIR}"
	# Fix paths to avoid sandbox access violation
	# 'emake DESTDIR=${D} install' does not work with compiz cmake files!
	for i in `find . -type f -name "cmake_install.cmake"`;do
		sed -e "s|/usr|${D}/usr|g" -i "${i}"  || die "sed failed"
		sed -e "s|/etc|${D}/etc|g" -i "${i}"  || die "sed failed"
	done
	emake install
	popd

	rm ${D}/usr/share/glib-2.0/schemas/gschemas.compiled
}

pkg_preinst() {
	use gnome && gnome2_gconf_savelist
}

pkg_postinst() {
	use gnome && gnome2_gconf_install
	use gnome && gnome2_schemas_update
	if use dbus; then
		ewarn "The dbus plugin is known to crash compiz in this version. Disable"
		ewarn "it if you experience crashes when plugins are enabled/disabled."
	fi
}

pkg_prerm() {
	use gnome && gnome2_gconf_uninstall
	use gnome && gnome2_schemas_update
}
