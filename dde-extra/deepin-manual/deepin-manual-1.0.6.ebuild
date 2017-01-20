# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5


DESCRIPTION="Deepin User Manual"
HOMEPAGE="https://github.com/linuxdeepin/deepin-manual"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dde-extra/deepin-qml-widgets
		dev-python/dae
		dev-python/jieba
		dev-python/pygobject:3
		dev-lang/sassc
		net-libs/nodejs[npm]
	    "

src_prepare() {
	sed -e 's_ln -sf /usr/bin/nodejs ./symdir/node__' \
		-e 's/sass /sassc /' \
		-e 's/--unix-newlines//' \
		-i Makefile
}
