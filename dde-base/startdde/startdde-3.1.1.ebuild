# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5


DESCRIPTION="starter of Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/startdde"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/dde-daemon
 		dde-base/deepin-wm-switcher
		"

DEPEND="${RDEPEND}
	      net-libs/webkit-gtk
	      dev-lang/coffee-script
	      dev-go/go-dbus-generator
	      dev-util/cmake
	      dev-go/deepin-go-lib
	      dev-go/dbus-factory"

src_prepare() {
# 	  sed -i 's|${GOPATH}:${CURDIR}/${GOBUILD_DIR}|${CURDIR}/${GOBUILD_DIR}:${GOPATH}|g' Makefile
	  export GOPATH="/usr/share/gocode"
}

src_install() {
	  emake DESTDIR="${D}" install
	  mv ${D}/lib/systemd ${D}/usr/lib/systemd
	  rm -r ${D}/lib
	  dosym ../dde-readahead.service /usr/lib/systemd/system/multi-user.target.wants/dde-readahead.service

}
