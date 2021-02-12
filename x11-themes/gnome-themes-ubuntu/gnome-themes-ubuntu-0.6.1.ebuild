# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="GNOME themes from Ubuntu"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/g/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-3 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~sh ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	x11-themes/humanity-icon-theme
	x11-themes/dmz-cursor-theme
	x11-themes/gtk-engines
	x11-themes/gtk-engines-murrine"

RESTRICT="binchecks mirror strip"

src_install() {
	dodir /usr/share/themes
	sed -i -r 's|(CursorTheme=)default|\1DMZ-White|' "New Wave"/index.theme || die
	cp -r "${S}"/{Dust,New}* "${D}"/usr/share/themes || die "install failed."

	dodoc "${S}"/debian/{changelog,copyright} || die "install doc failed."
}
