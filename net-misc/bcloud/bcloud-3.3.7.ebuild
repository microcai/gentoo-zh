# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5

inherit fdo-mime versionator eutils python gnome2-utils

DESCRIPTION="Baidu Pan client for Linux Desktop users"
HOMEPAGE="https://github.com/LiuLang/bcloud"

SRC_URI="https://pypi.python.org/packages/source/b/bcloud/${P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-lang/python-3.3[sqlite]
	dev-python/urllib3
	dev-python/pygobject
	dev-python/keyring
	dev-python/dbus-python
	x11-themes/gnome-icon-theme-symbolic"
DEPEND=""

S=${WORKDIR}/${P}

pkg_setup() {
	python_set_active_version 3.3
}

src_compile() {
	python setup.py build
}

src_install() {
	python setup.py install
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
