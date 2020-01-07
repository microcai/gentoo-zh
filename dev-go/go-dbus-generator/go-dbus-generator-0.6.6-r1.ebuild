# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Convert D-Bus interfaces to go-lang or qml wrapper code"
HOMEPAGE="https://github.com/linuxdeepin/go-dbus-generator"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="dev-qt/qtdeclarative:5
	dev-go/deepin-go-lib"

src_prepare() {
	export GOPATH="${S}:/usr/lib/go-gentoo"
}

