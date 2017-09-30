# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="QML Movie Player based on QtAV"
HOMEPAGE="https://github.com/linuxdeepin/deepin-movie"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

PY_TAR_VER="python_targets_python2_7"
DEPEND="media-video/mediainfo
		dev-python/python-ass[${PY_TAR_VER}]
		dev-python/dbus-python[${PY_TAR_VER}]
		sys-apps/file[python,${PY_TAR_VER}]
		dev-python/pyopengl[${PY_TAR_VER}]
		dev-python/peewee[${PY_TAR_VER}]
		dev-python/xpybutil
		dev-python/sip[${PY_TAR_VER}]
		dev-python/PyQt5[${PY_TAR_VER}]
		dev-python/bottle[${PY_TAR_VER}]
		dev-python/pysrt[${PY_TAR_VER}]
		media-libs/qtav
		dde-extra/deepin-gettext-tools
		"
RDEPEND="${DEPEND}
		dde-base/deepin-menu
		dde-extra/deepin-qml-widgets"

src_prepare() {
	# fix python version
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='
}

src_compile() {
	python2 configure.py
	deepin-generate-mo locale/locale_config.ini
}

src_install() {
	emake DESTDIR=${D} install
	fperms 0755 /usr/share/deepin-movie/main.py 
}
