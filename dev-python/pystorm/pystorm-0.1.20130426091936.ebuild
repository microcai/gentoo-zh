# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils python

MY_VER="$(get_version_component_range 1-2)+git$(get_version_component_range 3)"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/p/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Download library and tool for Linux Deepin project"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python:2.7
		dev-python/gevent"
DEPEND="${RDEPEND}
		dev-python/setuptools
		dev-util/intltool"
S=${WORKDIR}/${PN}-${MY_VER}

pkg_setup() {
	python_set_active_version 2.7
}

src_install() {

	python setup.py install --root=${D} || die "Install failed"
}
