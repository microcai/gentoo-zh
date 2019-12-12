# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 gnome2-utils versionator

DESCRIPTION="An onscreen keyboard useful for tablet PC users and for mobility impaired users"
HOMEPAGE="https://launchpad.net/onboard"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

# po/* are licensed under BSD 3-clause
LICENSE="GPL-3+ BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="app-text/hunspell:=
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	sys-apps/dbus
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[introspection]
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	x11-libs/libwnck:3
	x11-libs/pango"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	app-accessibility/at-spi2-core
	app-text/iso-codes
	gnome-extra/mousetweaks
	x11-libs/libxkbfile"

RESTRICT="mirror"

src_prepare() {
	distutils-r1_src_prepare
	eapply_user
}

src_install() {
	distutils-r1_src_install

}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
