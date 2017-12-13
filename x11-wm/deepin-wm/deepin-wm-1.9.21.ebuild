# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils vala autotools-utils

DESCRIPTION="Deepin Window Manager"
HOMEPAGE="https://github.com/linuxdeepin/deepin-wm"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	dev-libs/granite
	>=x11-libs/bamf-0.2.20
	>=x11-libs/gtk+-3.4:3
	>=x11-wm/deepin-mutter-3.20.22
	gnome-base/gnome-desktop:3
	dde-base/deepin-menu
	>=dde-base/deepin-desktop-schemas-2.90.0"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch_user

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		VALAC="${VALAC}"
	)
	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
