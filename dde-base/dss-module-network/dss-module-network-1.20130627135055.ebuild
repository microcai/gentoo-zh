# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

DSS="deepin-system-settings"
MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~9f146c62a7"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${DSS}/${DSS}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings module for configuring network"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pptp l2tp"
RDEPEND="dde-base/deepin-system-settings
		dev-python/python-gudev
		dev-python/keyring
		net-libs/glib-networking
		net-misc/networkmanager
		dev-python/pytz
		pptp? ( net-misc/networkmanager-pptp )
		l2tp? ( net-misc/networkmanager-l2tp )
		net-misc/modemmanager"
DEPEND=""
S="${WORKDIR}/${DSS}-${MY_VER}/modules/network"

src_install() {
	# the networkmanager-0.9.8.2 need >=net-misc/modemmanager-0.7.991
	# and modemmanager-0.7.991 provide org.freedesktop.ModemManager1.service but
	# org.freedesktop.ModemManager.service
	sed -i "s|ModemManager|ModemManager1|g" ${S}/src/mm/mmclient.py
	
	insinto "/etc/dbus-1/system.d/"
	doins ${S}/src/nmlib/com.deepin.network.conf

	dolib ${S}/src/nmlib/network_service.py

	insinto "/usr/share/dbus-1/system-services"
	doins ${S}/src/nmlib/com.deepin.network.service
	
	insinto "/usr/share/polkit-1/actions"
	doins ${S}/src/nmlib/com.deepin.network.policy
	
	insinto "/usr/share/${DSS}/modules/network"
	doins -r ${S}/src ${S}/locale ${S}/__init__.py ${S}/config.ini

	rm ${D}/usr/share/${DSS}/modules/network/locale/*.po*
	fperms 0755 -R /usr/share/${DSS}/modules/network/src/main*.py

}

pkg_postinst() {
	elog ""
	elog "You may add networkmanager to default runlevel by running "
	elog "'rc-update add NetworkManager default' as root, so that "
	elog "the networkmanager can start at boot time and the network "
	elog "module of DSS can be loaded normally."
	elog ""
}
