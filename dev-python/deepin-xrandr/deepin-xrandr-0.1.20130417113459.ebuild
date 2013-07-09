# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime unpacker versionator

MY_VER="$(get_version_component_range 1-2)+git$(get_version_component_range 3)"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin XRandR Python Bindings"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


RDEPEND="dev-lang/python:2.7
		>=sys-libs/glibc-2.7
		x11-libs/libX11
		>=x11-apps/xrandr-1.2.99"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${MY_VER}

pkg_setup() {
	python_set_active_version 2.7
}

src_install() {

	python setup.py install --root=${D} || die "Install failed"
}

