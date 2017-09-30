# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="D-Bus library binding for golang"
HOMEPAGE="https://github.com/linuxdeepin/dbus-factory"
SRC_URI="https://github.com/linuxdeepin/dbus-factory/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc[go]
	dev-lang/go
	dev-go/go-dbus-generator"

src_prepare() {
	export GOPATH="/usr/share/gocode"
}
