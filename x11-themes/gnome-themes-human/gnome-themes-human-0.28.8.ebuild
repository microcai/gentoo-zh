# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="human-theme"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="GNOME themes from Ubuntu"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/h/${MY_PN}/${MY_PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~sh ~x86 ~x86-fbsd"
IUSE="ubuntulooks"

RDEPEND="
	x11-themes/human-icon-theme
	x11-themes/dmz-cursor-theme
	x11-themes/gtk-engines-murrine
	ubuntulooks? ( x11-themes/gtk-engines-ubuntulooks )
	!ubuntulooks? ( !x11-themes/gtk-engines-ubuntulooks )"

S="${WORKDIR}/${MY_P}"
RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/themes
	mv "${S}"/DarkRoom/index.theme.in "${S}"/DarkRoom/index.theme
	sed -i -e s/"^_"/""/ "${S}"/DarkRoom/index.theme || die
	sed -i -e s/"CursorTheme=default"/"CursorTheme=DMZ-White"/ "${S}"/DarkRoom/index.theme || die
	doins -r "${S}"/DarkRoom

	insinto /usr/share/themes/Human
	mv "${S}"/index.theme.in "${S}"/index.theme
	sed -i -e s/"^_"/""/ "${S}"/index.theme || die
	sed -i -e s/"CursorTheme=Human"/"CursorTheme=DMZ-White"/ "${S}"/index.theme || die
	doins "${S}"/index.theme

	doins "${S}"/cursor.theme
	if ! use ubuntulooks ; then
		doins -r "${S}"/Human/gtk-2.0
	fi

	insinto /usr/share/themes/Human/metacity-1
	doins "${S}"/metacity/Human/*

	insinto /usr/share/themes
	mv "${S}"/Human-Clearlooks/index.theme.in "${S}"/Human-Clearlooks/index.theme
	sed -i -e s/"^_"/""/ "${S}"/Human-Clearlooks/index.theme || die
	sed -i -e s/"CursorTheme=default"/"CursorTheme=DMZ-White"/ "${S}"/Human-Clearlooks/index.theme || die
	doins -r "${S}"/Human-Clearlooks

	dodoc "${S}"/debian/{changelog,copyright} || die "install doc failed."
}
