# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Zhang Le
# Purpose: compile and install chinese fortune, regenerate fortune-zh.conf 
#

inherit eutils

ECLASS="fortune-zh"
EXPORT_FUNCTIONS src_compile src_install pkg_postinst pkg_postrm

HOMEPAGE="http://code.google.com/p/chinese-fortune/"
SRC_URI="http://chinese-fortune.googlecode.com/files/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="games-misc/fortune-mod-zh
	app-i18n/zh-autoconvert"

CONF="/etc/fortune-zh.conf"
NAME="${PN/fortune-mod-/}"

fortune-zh_src_compile() {
	emake $NAME.dat
}

fortune-zh_src_install() {
	insinto /usr/share/fortune
	doins $NAME $NAME.dat
	dosym $NAME /usr/share/fortune/$NAME.u8
}


fortune-zh_pkg_postinst() {
	einfo "Adding ${NAME} to $CONF"
	echo ${NAME} >> $CONF
	chmod 644 $CONF
}

fortune-zh_pkg_postrm() {
	einfo "Removing ${NAME} from $CONF"
	sed -i -e "/${NAME}/d" $CONF
	chmod 644 $CONF
}
