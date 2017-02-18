# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit fdo-mime versionator eutils python

MY_VER="$(get_version_component_range 1-3)-1+git$(get_version_component_range 4)ubuntu2"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Utils of DeepinUI Toolkit modules"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-libs/glibc-2.14
		>=dev-libs/glib-2.24.0:2
		>=dev-lang/python-2.7:2.7
		x11-libs/cairo
		dev-python/pycairo
		x11-libs/gtk+:2
		dev-python/pygtk:2
		net-libs/webkit-gtk:2
		dev-python/pywebkitgtk
		dev-python/python-xlib
		>=media-libs/freetype-2.2.1:2
		>=net-libs/libsoup-2.26.1"
DEPEND="${RDEPEND}
		dev-python/setuptools"
S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

pkg_setup() {
	python_set_active_version 2.7
}

src_install() {

	python setup.py install --root=${D} || die "Install failed"
}
