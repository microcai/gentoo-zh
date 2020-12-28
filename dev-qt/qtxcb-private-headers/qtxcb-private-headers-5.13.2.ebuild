# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="The Private Headers for the Qt5 Xcb"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 x86 ~amd64-fbsd"
fi

# TODO: linuxfb

IUSE=""

RDEPEND="
	~dev-qt/qtgui-${PV}
"
DEPEND="${RDEPEND}"

QT5_TARGET_SUBDIRS=(
	src/plugins/platforms/xcb
)


#QT5_GENTOO_PRIVATE_CONFIG=(
#	:gui
#)


src_compile() { :; }
src_test() { :; }

src_install() {
	insinto ${QT5_HEADERDIR}/QtXcb/${PV}/QtXcb/private/
	doins src/plugins/platforms/xcb/*.h
}
