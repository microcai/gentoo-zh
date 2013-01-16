# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ESVN_REPO_URI="http://kgtp.googlecode.com/svn/trunk"
inherit linux-info linux-mod subversion
DESCRIPTION="A realtime and lightweight Linux debugger and tracer."
HOMEPAGE="http://kgtp.googlecode.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

CONFIG_CHECK="MODULES KPROBES DEBUG_FS DEBUG_INFO"

src_install() {
	insinto "/lib/modules/${KV_FULL}/kernel/drivers/kgtp/"
	doins gtp.ko 
	dobin getframe getmod getmod.py getgtprsp.pl add-ons/*
	dodoc howto.txt howtocn.txt quickstart.txt
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		depmod -a
	fi
	einfo "If you have problems loading the module, please check the \"dmesg\" output."
}
