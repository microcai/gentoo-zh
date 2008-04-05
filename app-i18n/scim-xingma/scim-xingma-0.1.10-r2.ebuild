# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Tables for XingMa, A tabe Input Methon Engine"
HOMEPAGE="http://code.google.com/p/scim-python/"
SRC_URI="zhengma? ( http://scim-python.googlecode.com/files/xingma-zhengma-${PV}.tar.bz2 )
	wubi? ( http://scim-python.googlecode.com/files/xingma-wubi86-${PV}.tar.bz2 )
	erbi-qs? ( http://scim-python.googlecode.com/files/xingma-erbi-qingsong-${PV}.tar.bz2 )
	cangjie5? ( http://scim-python.googlecode.com/files/xingma-cangjie5-${PV}.tar.bz2 )"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="zhengma wubi erbi-qs cangjie5"

RDEPEND=">app-i18n/scim-python-0.1.9"
DEPEND="${RDEPEND}"

pkg_setup() {
	if ! built_with_use '>=app-i18n/scim-python' xingma; then
		echo
		ewarn "You need build app-i18n/scim-python with \"xingma\" USE flag"
		ewarn "OtherWise you Can Not use this tables."
		echo
		ebeep 3
	fi
}

src_compile(){
	for b in $(find "${WORKDIR}" -iname '*.bz2'); do
		echo $b
		python "/usr/share/scim-python/engine/XingMa/XMCreateDB.py" -s $b
	done
}

src_install() {
	dodir /usr/share/scim/icons
	for p in $(find "${WORKDIR}" -iname '*.png'); do
		mv "${p}" "${D}/usr/share/scim/icons/"
	done
	dodir /usr/share/scim-python/engine/XingMa/tables
	for d in $(find "${WORKDIR}" -iname '*.db'); do
		mv "${d}" "${D}/usr/share/scim-python/engine/XingMa/tables/"
	done
}

pkg_postinst() {
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	einfo "Please report all bugs to scim-python project"
	einfo "\thttp://code.google.com/p/scim-python/issues/list"
	einfo
}
