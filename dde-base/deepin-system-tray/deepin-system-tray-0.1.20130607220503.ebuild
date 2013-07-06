# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

MY_VER="$(get_version_component_range 1-2)-1+git$(get_version_component_range 3)~d6e474fe86"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="System tray for Deepin Desktop Environment"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/deepin-system-settings"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_prepare() {
	sed -i "s|/usr/bin/python|/usr/bin/python2|g" ${S}/debian/${PN}.desktop
}

src_install() {
	insinto "/etc/xdg/autostart/"
	doins ${S}/debian/${PN}.desktop

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src
	#fperms 0755 -R /usr/share/${PN}/src/

}

