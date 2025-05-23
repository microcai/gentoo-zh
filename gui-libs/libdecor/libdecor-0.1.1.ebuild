# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A client-side decorations library for Wayland clients"
HOMEPAGE="https://gitlab.freedesktop.org/libdecor/libdecor"
SRC_URI="https://gitlab.freedesktop.org/libdecor/libdecor/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dbus examples"

DEPEND="
	>=dev-libs/wayland-1.18
	>=dev-libs/wayland-protocols-1.15
	x11-libs/pango
	dbus? ( sys-apps/dbus )
	examples? (
		virtual/opengl
		media-libs/mesa[egl(+)]
		x11-libs/libxkbcommon
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		# Avoid auto-magic, built-in feature of meson
		-Dauto_features=disabled

		$(meson_feature dbus)
		$(meson_use examples demo)
		-Dinstall_demo=true
	)

	meson_src_configure
}
