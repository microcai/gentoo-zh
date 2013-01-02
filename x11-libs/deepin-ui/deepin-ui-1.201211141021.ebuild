# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"
PYTHON_DEPEND=2:2.7

inherit python versionator

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_$(get_version_component_range \
	1)+git$(get_version_component_range 2).tar.gz"

DESCRIPTION="UI toolkit for Linux Deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-ui"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pycairo
		dev-python/pygtk
		net-libs/libsoup
		net-libs/webkit-gtk"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-$(get_version_component_range \
	1)+git$(get_version_component_range 2)
pkg_setup() {
	python_set_active_version 2.7
	python_pkg_setup
}

src_prepare() {
	sed -i 's|webkit-1.0|webkitgtk-3.0|g' $S/setup.py || die "Sed failed!"
	sed -i 's|webkitgtk-1.0|webkitgtk-3.0|g' $S/setup.py || die "Sed failed!"
}
src_install() {
	dodoc AUTHORS README
	python setup.py install \
		--root="${D}" \
		--optimize=2 || die "Install failed!"

	mv ${D}/usr/dtk/theme ${D}/usr/$(get_libdir)/python2.7/site-packages/dtk || die
	mv ${D}/usr/dtk/locale ${D}/usr/share/ || die
	rm ${D}/usr/share/locale/*.po*
	rm -r ${D}/usr/dtk


}

