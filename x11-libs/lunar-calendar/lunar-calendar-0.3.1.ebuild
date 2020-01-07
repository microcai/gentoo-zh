# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=7

inherit fdo-mime versionator

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"

DESCRIPTION="Chinese Lunar Calendar library fork by LinuxDeepin project"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="deepin"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/gobject-introspection
		dev-libs/glib:2
		x11-libs/gtk+:2
		dev-libs/dtk-widget
		dev-libs/lunar-date
		!x11-libs/lunar-calendar:2"
DEPEND="${RDEPEND}
		dev-util/gtk-doc"
S="${WORKDIR}"

src_prepare() {
	#sed -i 's|liblunar_calendar_preload_2_0_include_HEADERS =\
	#	 $(source_h)|#liblunar_calendar_preload_2_0_include_HEADERS = $(source_h)|g'\
	#	 lunar-calendar/Makefile.am
	./autogen.sh 
}
