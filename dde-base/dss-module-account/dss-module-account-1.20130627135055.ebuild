# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils python

DSS="deepin-system-settings"
MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~9f146c62a7"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${DSS}/${DSS}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings module for configuring accounts"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-auth/polkit
		dde-base/deepin-system-settings
		dev-python/pexpect
		media-plugins/gst-plugins-x:0.10
		media-plugins/gst-plugins-xvideo:0.10
		media-plugins/gst-plugins-pango:0.10"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${DSS}-${MY_VER}/modules/account"

pkg_setup() {
	python_set_active_version 2.7
}

src_install() {

	cd ${S}/src 
	python setup.py install \
		--root="${D}" || die "Install failed"
	cd ${S}

	insinto "/usr/share/dbus-1/system-services"
	doins ${S}/src/com.deepin.passwdservice.service

	insinto "/usr/share/polkit-1/actions/"
	doins ${S}/src/com.deepin.passwdservice.policy

	insinto "/etc/dbus-1/system.d/"
	doins ${S}/src/com.deepin.passwdservice.conf

	dolib ${S}/src/passwdservice.py

	insinto "/var/lib/AccountsService/icons/"
	doins ${S}/faces/*

	insinto "/usr/share/${DSS}/modules/account/"
	doins -r ${S}/faces ${S}/locale \
		${S}/__init__.py ${S}/config.ini
	
	insinto "/usr/share/${DSS}/modules/account/src"
	doins ${S}/src/*.py

	rm ${D}/usr/share/${DSS}/modules/account/locale/*.po*

}
