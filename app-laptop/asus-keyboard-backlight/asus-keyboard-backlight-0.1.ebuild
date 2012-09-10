# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Configure the brightness of the keyboard's backlight on ASUS
laptops."
HOMEPAGE="http://projects.flogisoft.com/asus-keyboard-backlight/"
SRC_URI="http://projects.flogisoft.com/${PN}/download/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="${DEPEND}
	dev-lang/python
	sys-power/acpid"

S="${WORKDIR}/asus-kbd-backlight-${PV}"

src_install(){
	#Install
	#$1 : the output path, if different of /
	#ACPI events
	dodir /etc/acpi/events/
	cp -v ./events/* "$D"/etc/acpi/events/
	#ACPI script
	cp -v ./code/asus-kbd-backlight.py "$D"/etc/acpi/
	chmod 755 "$D"/etc/acpi/asus-kbd-backlight.py
	#Resume script
	dodir /etc/pm/sleep.d/
	cp -v ./code/asus-kbd-backlight_resume.sh "$D"/etc/pm/sleep.d/80_asus-kbd-backlight
	chmod 755 "$D"/etc/pm/sleep.d/80_asus-kbd-backlight
	#Init script
	dodir	/etc/init.d/
	cp -v ./code/asus-kbd-backlight_init.sh  "$D"/etc/init.d/asus-kbd-backlight
	chmod 755 "$D"/etc/init.d/asus-kbd-backlight

	#Bak
	dodir /var/lib/asus-kbd-backlight/
	echo 1 > "$D"/var/lib/asus-kbd-backlight/brightness
}
