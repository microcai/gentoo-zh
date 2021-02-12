# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="LXDE theme for IceWM"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${PN}.tar.bz2"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc amd64 sparc"

IUSE=""

RDEPEND="x11-wm/icewm"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -name \.xvpics | xargs rm -rf
	find . -name \*~ | xargs rm -rf
	find . -name .svn | xargs rm -rf
}

src_install() {
	local ICEWM_THEMES=/usr/share/icewm/themes
	dodir ${ICEWM_THEMES}
	cp -pR * ${D}/${ICEWM_THEMES}
	chown -R root:0 ${D}/${ICEWM_THEMES}
	rm -f ${D}/${ICEWM_THEMES}/Crus-IceWM/cpframes.sh || die
	find ${D}/${ICEWM_THEMES} -type d | xargs chmod 755 || die
	find ${D}/${ICEWM_THEMES} -type f | xargs chmod 644 || die
}
