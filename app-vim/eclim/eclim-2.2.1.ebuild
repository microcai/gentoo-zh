# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

VIM_PLUGIN_VIM_VERSION="7.1"
inherit java-utils-2 java-pkg-2 java-ant-2 vim-plugin
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
DESCRIPTION="vim plugin: The power of Eclipse in your favorite VIM."
HOMEPAGE="http://eclim.org/"
LICENSE="GPL-3"
KEYWORDS="amd64 x86"

IUSE=""

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""

DEPEND=">=virtual/jdk-1.6.0"
RDEPEND=">=virtual/jre-1.6.0"

S=${WORKDIR}

src_compile(){
	ant -Declipse.home=/usr/$(get_libdir)/eclipse


}

pkg_setup(){

	die "please see http://aur.archlinux.org/packages/ec/eclim/PKGBUILD and fix
	this ebuild."
}
