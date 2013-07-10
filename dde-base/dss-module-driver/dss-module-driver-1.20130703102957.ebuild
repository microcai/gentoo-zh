# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

DSS="deepin-system-settings"
MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~7295fcb0a0"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${DSS}/${DSS}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings module for configuring driver"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/deepin-system-settings"
DEPEND=""
S="${WORKDIR}/${DSS}-${MY_VER}/modules/driver"

src_install() {

	insinto "/usr/share/${DSS}/modules/driver"
	doins -r  ${S}/src ${S}/config.ini
	fperms 0755 -R /usr/share/${DSS}/modules/driver/src/

}

pkg_postinst() {
	elog ""
	elog "Because the driver module of DSS call the binary 'jockey-gtk'"
	elog "to be functional, but the driver manager 'jockey' is just worked"
	elog "on the distributions base on APT. So this module is just an icon"
	elog "list in Deepin System Settings without any function on Gentoo."
	elog ""
}