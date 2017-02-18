# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit fdo-mime eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Deepin Internationalization utilities"
HOMEPAGE="https://github.com/linuxdeepin/deepin-gettext-tools"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

RDEPEND="dev-lang/python:2.7
		sys-devel/gettext"
DEPEND="${RDEPEND}
		dev-qt/qtdeclarative:5
		"


src_prepare() {
	# fix python version
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='

	# remove sudo in generate_mo.py
	sed -e 's/sudo cp/cp/' -i src/generate_mo.py || die "sed failed"
	
}

