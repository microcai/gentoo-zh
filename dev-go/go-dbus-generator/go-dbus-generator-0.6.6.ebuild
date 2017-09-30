# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4


DESCRIPTION="Convert D-Bus interfaces to go-lang or qml wrapper code"
HOMEPAGE="https://github.com/linuxdeepin/go-dbus-generator"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="sys-devel/gcc[go]
	dev-lang/go
	dev-qt/qtdeclarative:5
	dev-go/deepin-go-lib"

src_prepare() {
	 export GOPATH="${S}:/usr/share/gocode"
}

# src_compile() {
# 	go build -o dbus-generator
# }
# 
# src_install() {
# 	dobin dbus-generator
# }
