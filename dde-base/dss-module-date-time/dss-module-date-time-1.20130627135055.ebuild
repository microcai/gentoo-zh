# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils python

DSS="deepin-system-settings"
MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~9f146c62a7"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${DSS}/${DSS}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings module for configuring date and time"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python:2.7
		dde-base/deepin-system-settings
		dev-python/dtk-widget
		dev-libs/lunar-date
		dev-libs/lunar-calendar
		dev-python/deepin-lunar"
DEPEND=""
S="${WORKDIR}/${DSS}-${MY_VER}/modules/date_time"

pkg_setup() {
	python_set_active_version 2.7
}

src_install() {

	cd ${S}/src
	python setup.py install --root=${D} || die "Install failed"

	insinto "/usr/share/${DSS}/modules/date_time/src"
	doins ${S}/src/*.py

	insinto "/usr/share/${DSS}/modules/date_time"
	doins -r  ${S}/locale ${S}/__init__.py ${S}/config.ini

	rm ${D}/usr/share/${DSS}/modules/date_time/locale/*.po* \
		${D}/usr/share/${DSS}/modules/date_time/src/setup.py
	fperms 0755 -R /usr/share/${DSS}/modules/date_time/src/

}
