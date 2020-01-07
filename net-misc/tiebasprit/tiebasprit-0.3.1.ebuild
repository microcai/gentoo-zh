# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit googlecode

DESCRIPTION="百度贴吧守护精灵 - 百度贴吧广告删贴机器人"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_compile(){
	echo "#! /bin/bash " >>   ${PN}
	echo "cd /usr/${PN}" >>   ${PN}
	echo "exec python main.py" >>   ${PN}
	chmod a+x ${PN}
}

src_install(){
	dodir /usr/bin
	install ${PN} ${D}/usr/bin

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins dirty_words.conf
	doins main.conf
	doins main.py
	doins ReadMe
	doins tieba_list.conf
	doins tieba.py

	ewarn please check /usr/${PN}/ReadMe and configure it porperly 
}
