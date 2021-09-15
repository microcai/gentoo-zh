# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Chinese Lunar Library"
HOMEPAGE="https://github.com/yetist/lunar-date"
SRC_URI="https://github.com/yetist/lunar-date/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+dbus doc introspection test"

RDEPEND=">=dev-python/pygobject-2.11.5"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS COPYING NEWS README.md"

src_configure(){
	local emesonargs=(
		$(meson_use dbus enable_dbus_service)
		$(meson_use doc enable_gtk_doc)
		$(meson_use introspection with_introspection)
		$(meson_use test enable_tests)
	)
	meson_src_configure
}
