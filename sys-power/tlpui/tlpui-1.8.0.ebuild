# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_SINGLE_IMPL=y
inherit distutils-r1 desktop xdg-utils

if [[ $(ver_cut 4) == "p" ]] ; then
	MY_PV="$(ver_cut 1-3)-$(ver_cut 5)"
else
	MY_PV="${PV}"
fi

MY_P="${PN}-${MY_PV}"

DESCRIPTION="A GTK user interface for TLP written in Python"
HOMEPAGE="https://github.com/d4nj1/TLPUI"
SRC_URI="https://github.com/d4nj1/TLPUI/archive/refs/tags/${MY_P}.tar.gz"
S="${WORKDIR}/TLPUI-${MY_P}"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	sys-apps/usbutils
	sys-power/tlp
	$(python_gen_cond_dep 'dev-python/pycairo[${PYTHON_USEDEP}] dev-python/pygobject[${PYTHON_USEDEP}]')
	x11-libs/gtksourceview:3.0
"

python_install_all() {
	distutils-r1_python_install_all
	doicon -s scalable "${S}/tlpui/icons/themeable/hicolor/scalable/apps/tlpui.svg"
	insinto /usr/share/metainfo
	doins "${S}/AppImage/com.github.d4nj1.tlpui.appdata.xml"
	domenu "${S}/tlpui.desktop"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
