# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="ubuntu-gdm-themes"
DESCRIPTION="GDM themes from Ubuntu"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/u/${MY_PN}/${MY_PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="gnome-base/gdm"

S="${WORKDIR}/${MY_PN}"
RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/gdm/themes
	for dir in Human HumanCircle HumanList ; do
		mv "${S}"/${dir}/GdmGreeterTheme.desktop.in "${S}"/${dir}/GdmGreeterTheme.desktop
		sed -i -e s/"^_"/""/ "${S}"/${dir}/GdmGreeterTheme.desktop || die
		doins -r "${S}"/${dir} || die
	done

	dodoc "${S}"/debian/{changelog,copyright} || die "install doc failed."
}
