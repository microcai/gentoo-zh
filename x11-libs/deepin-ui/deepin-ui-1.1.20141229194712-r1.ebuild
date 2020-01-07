# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=true
inherit distutils-r1 versionator

MY_VER="$(get_version_component_range 1-2)+$(get_version_component_range 3)~5a86faec50"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="UI toolkit for Linux Deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-ui"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.7.5:2.7
		x11-libs/gtk+:2
		x11-libs/cairo
		dev-python/pygtk:2
		net-libs/webkit-gtk
		dev-python/pywebkitgtk
		sci-libs/scipy
		dev-python/python-xlib
		dev-python/deepin-utils
		dev-python/deepin-gsettings
		|| ( dev-python/imaging dev-python/pillow )"
DEPEND="${RDEPEND}
		dev-python/pycairo
		dev-python/setuptools
		sys-devel/gettext"

S=${WORKDIR}/${PN}-${MY_VER}


