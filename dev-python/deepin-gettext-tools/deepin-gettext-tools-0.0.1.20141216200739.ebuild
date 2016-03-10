# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime eutils versionator


MY_VER="$(get_version_component_range 1-3)+$(get_version_component_range 4)~6ba50ecb9c"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"
KEYWORDS="~amd64 ~x86"
S=${WORKDIR}/${PN}-${MY_VER}

DESCRIPTION="Deepin Internationalization utilities"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-3"
SLOT="0"
IUSE="qt5"

RDEPEND="dev-lang/python:2.7
		sys-devel/gettext"
DEPEND="qt5? ( 
			dev-qt/qtdeclarative:5
			dev-qt/qtchooser[qt5]
			)"

S=${WORKDIR}/${PN}-${MY_VER}

src_prepare() {
	# fix python version
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='

	# remove sudo in generate_mo.py
	sed -e '61s/sudo cp/cp/' -e '85s/sudo cp/cp/' -i src/generate_mo.py || die "sed failed"
	
}

src_compile(){
	use qt5 && emake build

}

src_install() {
	insinto "/usr/lib/${PN}"
	doins ${S}/src/*.py
	fperms 0755 /usr/lib/${PN}/generate_mo.py /usr/lib/${PN}/update_pot.py
	fperms 0644 /usr/lib/${PN}/blank.py
	
	dosym /usr/lib/${PN}/generate_mo.py  /usr/bin/deepin-generate-mo
	dosym /usr/lib/${PN}/update_pot.py  /usr/bin/deepin-update-pot
	
}
