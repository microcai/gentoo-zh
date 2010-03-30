# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Includes Ambiance and Radiance themes"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/l/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~sh ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	x11-themes/dmz-cursor-theme
	=x11-themes/gtk-engines-murrine-9999
	x11-themes/humanity-icon-theme
	x11-themes/ubuntu-mono"

RESTRICT="binchecks strip"

src_install() {
	dodir /usr/share/themes
	cp -R *iance "${D}"/usr/share/themes

	dodoc "${S}"/debian/{changelog,copyright} || die "install doc failed."
}
