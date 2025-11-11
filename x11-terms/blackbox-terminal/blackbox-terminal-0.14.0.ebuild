# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3 or later

EAPI=8

inherit meson gnome2-utils xdg vala

DESCRIPTION="A beautiful GTK 4 terminal"
HOMEPAGE="https://gitlab.gnome.org/raggesilver/blackbox"
SRC_URI="https://gitlab.gnome.org/raggesilver/blackbox/-/archive/v${PV}/blackbox-v${PV}.tar.bz2
	-> ${P}.tar.bz2"

S="${WORKDIR}/blackbox-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.0:2
	>=dev-libs/json-glib-1.0
	>=dev-libs/libpqmarble-2.0.0
	>=gui-libs/gtk-4.0:4
	>=gui-libs/libadwaita-1.0:1
	>=dev-libs/libgee-0.20:0.8
	>=gui-libs/vte-0.70:2.91-gtk4
	x11-libs/pango
"
RDEPEND="${DEPEND}"

BDEPEND="
	>=dev-lang/vala-0.56
	dev-libs/gobject-introspection
	virtual/pkgconfig
	sys-devel/gettext
"

# GCC 14 compatibility: Replace return*_if_fail macros
# https://gitlab.gnome.org/raggesilver/blackbox/-/commit/e50457a52aafcdfe0e230a3e6ec97eddc66eb989
PATCHES=(
	"${FILESDIR}/${PN}-0.14.0-gcc-14.patch"
)

src_prepare() {
	default
	vala_setup
}

src_configure() {
	meson_src_configure -Dblackbox_is_flatpak=false
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
