# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Fcitx Wrapper for sogoupinyin."
HOMEPAGE="http://code.google.com/p/fcitx"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/non-free/f/fcitx-sogoupinyin-release/${PN}-release_${PV}.orig.tar.gz"

LICENSE="Fcitx-Sogou"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.6"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${PN}-release-${PV}

src_configure(){
	#unpack "
	#	x86? ( arch/data.i386.tar.xz )
	#	amd64? ( arch/data.amd64.tar.xz )"
	echo "Current Directory"
	pwd
	if use x86; then
		unpack ./arch/data.i386.tar.xz
	elif use amd64; then
		unpack ./arch/data.amd64.tar.xz
	fi
}

src_install(){
	dodir /usr/lib/fcitx
	insinto /usr/lib/fcitx
	insopts -m0755
	doins ${S}/usr/lib/*-linux-gnu/fcitx/*

	insinto /usr/share
	doins -r ${S}/usr/share/fcitx
	doins -r ${S}/usr/share/icons
	doins -r ${S}/usr/share/locale
}

pkg_postinst(){
	einfo
	einfo "After install the fcitx-sogoupinyin, a restart of fcitx is"
	einfo "expected."
	einfo
	einfo "If you could not find Sogoupinyin in the Fcitx Input Method"
	einfo "choice box, you may need to remove your configure file of"
	einfo "fcitx-cloudpinyin, which locate in ~/.config/fcitx/addon and"
	einfo "~/.config/fcitx/conf."
	einfo
}
