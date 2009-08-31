# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2-utils

DESCRIPTION="Cursor themes from Ubuntu"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	=media-libs/libpng-1.2*
	x11-libs/libX11
	x11-libs/libXcursor"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/icons
	doins -r "${S}"/DMZ* || die "install failed."

	dodoc "${S}"/debian/{changelog,copyright} || die "install doc failed."
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
