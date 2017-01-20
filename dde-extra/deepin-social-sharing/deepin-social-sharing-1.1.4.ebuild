# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Deepin Social Sharing Service"
HOMEPAGE="https://github.com/linuxdeepin/deepin-social-sharing"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

RDEPEND="dev-lang/python:2.7
		dev-python/requests-oauthlib
		dev-python/PyQt5
		dev-python/requests
		dde-extra/deepin-qml-widgets
		"
DEPEND="${RDEPEND}
		dde-extra/deepin-gettext-tools
		"


src_prepare() {
	# fix python version
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='

}

