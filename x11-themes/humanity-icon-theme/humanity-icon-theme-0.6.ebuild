# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2-utils

DESCRIPTION="Elementary Icons for Humans."
HOMEPAGE="https://launchpad.net/humanity"
SRC_URI="mirror://ubuntu/pool/main/h/${PN}/${PN}_${PV}_all.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	>=x11-misc/icon-naming-utils-0.8.90
	media-gfx/imagemagick
	>=gnome-base/librsvg-2.26.0
	>=x11-themes/hicolor-icon-theme-0.10"
DEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

src_unpack() {
	default_src_unpack
	unpack ./data.tar.gz
}

src_install() {
	cp -r usr "${D}"
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
