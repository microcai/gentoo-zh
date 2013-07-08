# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils python

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/p/python-${PN}/python-${PN}_${PV}.orig.tar.gz"

DESCRIPTION="Deepin gsettings Python Bindings"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python:2.7
		dev-libs/glib
		dev-python/pygobject:2
		dev-python/pygtk:2
		dev-libs/dtk-widget
		dev-libs/lunar-date
		dev-libs/lunar-calendar"
DEPEND="${RDEPEND}
		dev-python/setuptools"
S=${WORKDIR}

pkg_setup() {
	python_set_active_version 2.7
}

src_install() {

	python setup.py install --root=${D} || die "Install failed"
}
