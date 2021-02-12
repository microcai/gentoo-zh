# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="AliWangWang for Linux"
HOMEPAGE="http://www.taobao.com/wangwang"
SRC_URI="amd64? ( http://tookubuntu.googlecode.com/files/${PN}_${PV}-00_amd64.deb )
	x86? ( http://tookubuntu.googlecode.com/files/${PN}_${PV}-00_i386.deb )"

LICENSE="FreeWare"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	>=dev-qt/qtgui-4.7
	>=dev-qt/qtwebkit-4.7
	>=dev-qt/qtcore-4.7
	>=dev-qt/qtsql-4.7
	>=dev-libs/openssl-1.0
	>=media-libs/fontconfig-2.8
	>=media-libs/freetype-2.4
	>=dev-libs/glib-2.32
	>=media-libs/libpng-1.5"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	default_src_unpack
	unpack ./data.tar.gz
	# not need for the crapy update
	rm usr/bin/AliWWAutoUpdate
}

src_install() {
	cp -r usr "${D}"
}
