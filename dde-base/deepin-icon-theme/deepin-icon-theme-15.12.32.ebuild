# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

DESCRIPTION="Deepin Icons"
HOMEPAGE="https://github.com/linuxdeepin/deepin-icon-theme"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-themes/flattr-icons
		media-gfx/inkscape
		dev-lang/python:2.7"


src_compile() {
	mkdir -p build
	python2 tools/convert.py deepin build
}
