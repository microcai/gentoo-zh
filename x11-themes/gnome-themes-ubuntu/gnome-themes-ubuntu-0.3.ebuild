# Copyright 1999-2009 Gentoo Foundation
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
	x11-themes/human-icon-theme
	x11-themes/dmz-cursor-theme
	x11-themes/gtk-engines"

S="${WORKDIR}/${PN}"
RESTRICT="binchecks strip"

src_install() {
	dodir /usr/share/themes
	sed -i -e s/"CursorTheme=default"/"CursorTheme=DMZ-White"/ "${S}/New Wave/index.theme" || die
	cp -R "${S}"/{Dust,New}* "${D}"/usr/share/themes

	dodoc "${S}"/debian/{changelog,copyright} || die "install doc failed."
}
