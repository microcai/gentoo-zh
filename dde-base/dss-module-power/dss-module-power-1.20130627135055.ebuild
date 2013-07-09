# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

DSS="deepin-system-settings"
MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~9f146c62a7"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${DSS}/${DSS}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings module for configuring power"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/deepin-system-settings"
DEPEND=""
S="${WORKDIR}/${DSS}-${MY_VER}/modules/power"

src_install() {

	insinto "/usr/share/${DSS}/modules/power"
	doins -r ${S}/locale ${S}/src ${S}/__init__.py ${S}/config.ini
	
	rm ${D}/usr/share/${DSS}/modules/power/locale/*.po*
	fperms 0755 -R /usr/share/${DSS}/modules/power/src/

}
