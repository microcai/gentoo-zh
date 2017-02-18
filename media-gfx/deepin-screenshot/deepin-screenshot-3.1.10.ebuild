# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit fdo-mime eutils

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://github.com/linuxdeepin/deepin-screenshot.git"
	inherit git-2
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-screenshot"

LICENSE="GPL-3+"
SLOT="3"
IUSE="sharing"

PY_TAR_VER="python_targets_python2_7"

RDEPEND="dev-lang/python:2.7
	dev-python/sip[${PY_TAR_VER}]
	dev-python/pyopengl[${PY_TAR_VER}]
	dev-python/libwnck-python
	dev-python/PyQt5[${PY_TAR_VER},multimedia]
	dde-base/deepin-menu
	dde-extra/deepin-qml-widgets
	dev-python/xpybutil

	sharing? ( dde-extra/deepin-social-sharing )
	!media-gfx/deepin-screenshot:2"
DEPEND="${RDEPEND}
		dde-extra/deepin-gettext-tools"

src_prepare() {
	# fix python version                                  
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='
}

