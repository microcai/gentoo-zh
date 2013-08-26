# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
# needed by make_desktop_entry
inherit eutils

MY_PN="Sublime%20Text"
MY_P="${MY_PN}%20${PV}"
S="${WORKDIR}/Sublime Text 2"

DESCRIPTION="Sublime Text is a sophisticated text editor for code, html and prose"
HOMEPAGE="http://www.sublimetext.com"
COMMON_URI="http://c758482.r82.cf2.rackcdn.com"
SRC_URI="amd64? ( ${COMMON_URI}/${MY_P}%20x64.tar.bz2 -> ${P}-x64.tar.bz2 )
x86? ( ${COMMON_URI}/${MY_P}.tar.bz2 -> ${P}-x86.tar.bz2 )"
LICENSE="Sublime"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.24.8-r1:2"

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}
	into /opt/${PN}
	exeinto /opt/${PN}
	doins -r "lib"
	doins -r "Pristine Packages"
	doins "sublime_plugin.py"
	doins "PackageSetup.py"
	doexe "sublime_text"
	dosym "/opt/${PN}/sublime_text" /usr/bin/subl

	# Icon and .desktop for sublime-text
	for icon in $(find Icon -name '*.png') ; do
		insinto /usr/share/`dirname $icon | sed 's/Icon/icons\/hicolor/'`/apps
		doins $icon
	done
	dosym ../icons/hicolor/48x48/apps/sublime_text.png usr/share/pixmaps/sublime_text.png
	make_desktop_entry "subl" "Sublime Text Editor" "sublime_text" "Development;TextEditor"
}
