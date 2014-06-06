# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5

#PYTHON_COMPAT=(python{3_3,3_4})
PYTHON_COMPAT="python3_3"

PYTHON_REQ_USE="sqlite3(+)"


inherit fdo-mime versionator eutils gnome2-utils python-single-r1


DESCRIPTION="Baidu Pan client for Linux Desktop users"
HOMEPAGE="https://github.com/LiuLang/bcloud"

SRC_URI="https://pypi.python.org/packages/source/b/bcloud/${P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	x11-themes/gnome-icon-theme-symbolic"
DEPEND=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

IUSE="-python_target_python3_4"

S=${WORKDIR}/${P}

pkg_setup() {
	python-single-r1_pkg_setup
	python_setup
}

src_compile() {
	export XDG_RUNTIME_DIR=${S}
	$PYTHON ./setup.py build
}

src_install() {
	export XDG_RUNTIME_DIR=${S}
	$PYTHON ./setup.py install  --root=${D} || die "Install failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
