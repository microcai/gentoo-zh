# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $
EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )
PYTHON_REQ_USE="sqlite"

if [[ $PV = *9999* ]]; then
	scm_eclass=git-r3
	EGIT_REPO_URI="
		https://github.com/LiuLang/bcloud.git
		https://github.com/LiuLang/bcloud.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/LiuLang/bcloud/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit python-r1 ${scm_eclass}

DESCRIPTION="Baidu Pan client for Linux Desktop users"
HOMEPAGE="https://github.com/LiuLang/bcloud"

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

IUSE+="gnome-keyring"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	x11-themes/gnome-icon-theme-symbolic
	x11-libs/libnotify
	gnome-keyring? ( gnome-base/libgnome-keyring  )
	"

src_install() {
	python_foreach_impl python_domodule ${PN}
	dobin bcloud-gui
	insinto usr
	doins -r share
}
