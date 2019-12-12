# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EBZR_REPO_URI="lp:gsettings-qt"

inherit qmake-utils bzr

DESCRIPTION="Qml bindings for GSettings."
HOMEPAGE="https://launchpad.net/gsettings-qt"
EBZR_REVISION="85"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	test? ( dev-qt/qttest:5 )"

unset QT_QPA_PLATFORMTHEME
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	eapply_user

	# Fix relocation error when rebuild with different Qt version
	sed -i 's|LD_PRELOAD=../src/libgsettings-qt.so.1|LD_PRELOAD=../src/libgsettings-qt.so.1\:./libGSettingsQmlPlugin.so|g' ${S}/GSettings/gsettings-qt.pro

	# Don't pre-strip
	echo "CONFIG+=nostrip" >> "${S}"/GSettings/gsettings-qt.pro
	echo "CONFIG+=nostrip" >> "${S}"/src/gsettings-qt.pro
	echo "CONFIG+=nostrip" >> "${S}"/tests/tests.pro

	use test || \
		sed -e 's:tests/tests.pro tests/cpptest.pro::g' \
			-i "${S}"/gsettings-qt.pro
}

src_configure() {
	QT_SELECT=qt5 eqmake5
}

src_install () {
	emake INSTALL_ROOT="${ED}" install
}
