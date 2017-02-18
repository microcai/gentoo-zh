# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
VALA_USE_DEPEND=vapigen

inherit autotools vala

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.30:2
	gnome-base/libgtop:2
	x11-libs/libX11
	x11-libs/gtk+:3
	x11-libs/libwnck:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	sed -i -e "s:-Wall -Werror::" configure.in || die
	eautoreconf

	vala_src_prepare
}

src_configure() {
	VALA_API_GEN="${VAPIGEN}" \
	econf \
		--with-gtk=3 \
		--disable-webapps \
		$(use_enable introspection)
}

src_install() {
	default
	find "${ED}" -name "*.la" -exec rm {} + || die
}
