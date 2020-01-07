# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
DISABLE_AUTOFORMATTING=true
inherit font readme.gentoo unpacker

DESCRIPTION="The wps-office-fonts package contains Founder Chinese fonts"
HOMEPAGE="http://wenq.org/wqy2/index.cgi?ZenHei"
SRC_URI="http://kdl.cc.ksosoft.com/wps-community/download/fonts/wps-office-fonts_1.0_all.deb"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86 ~x86-fbsd"
IUSE=""

S="$WORKDIR"

FONT_SUFFIX="ttf"

# Only installs fonts
RESTRICT="binchecks strip test"

pkg_postinst() {
	unset FONT_CONF # override default message
	font_pkg_postinst
}

src_install(){
	rm -rf ${D}
	mv ${S} ${D}
}

