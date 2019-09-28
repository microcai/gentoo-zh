# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="dbus"

inherit golang-base

DESCRIPTION="D-Bus library binding for golang"
HOMEPAGE="https://github.com/linuxdeepin/dbus-factory"
SRC_URI="https://github.com/linuxdeepin/dbus-factory/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-go/deepin-go-lib"
DEPEND="dev-lang/go
	dev-libs/libxml2
	app-misc/jq
	dev-go/go-dbus-generator"

src_prepare() {
	export GOPATH=$(get_golibdir_gopath)
	default
}
