# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils multilib

DESCRIPTION="PPLive and PPS IPTV support for GMLive"
HOMEPAGE="http://code.google.com/p/gmlive/"
SRC_URI="
	http://gmlive.googlecode.com/files/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pplive +pps +sopcast"

DEPEND=""
RDEPEND=""

RESTRICT="primaryuri"

QA_PRESTRIPPED="
	opt/sopcast/sp-sc-auth
	usr/lib32/libppsvodnet.so
	usr/lib32/libppsvodres.so.0
	usr/lib32/libppsfds.so
	usr/lib32/libppsbase.so.0
	usr/lib32/libppssg.so.0.1.826
	usr/lib32/libppsapi.so
	usr/lib32/libppsvodres.so
	usr/lib32/libppsvodnet.so.0
	usr/lib32/libppsbase.so
	usr/lib32/libppssg.so
	usr/lib32/libppsfds.so.0.1.826
	usr/lib32/libppssg.so.0
	usr/lib32/libppsbase.so.0.1.826
	usr/lib32/libppsvodnet.so.0.1.826
	usr/lib32/libppsfds.so.0
	usr/lib32/libppsapi.so.0
	usr/lib32/libppsapi.so.0.1.826
	usr/lib32/libppsvodres.so.0.1.826"
QA_TEXTRELS="
	usr/lib32/libppsvodnet.so
	usr/lib32/libppsbase.so.0
	usr/lib32/libppsapi.so
	usr/lib32/libppsvodnet.so.0
	usr/lib32/libppsbase.so
	usr/lib32/libppsbase.so.0.1.826
	usr/lib32/libppsvodnet.so.0.1.826
	usr/lib32/libppsapi.so.0
	usr/lib32/libppsapi.so.0.1.826"

src_prepare() {
	use amd64 && epatch "${FILESDIR}/${P}.patch"
}

src_compile() {
	if use pps ; then
		cd ppstream
		tar xvf ../lib-826.tar.gz
	fi
}

src_install() {
	exeinto /usr/bin

	if use pplive ; then
		doexe xpplive
	fi

	if use pps ; then
		cd "${S}"/ppstream
		use x86 || multilib_toolchain_setup x86
		mv {lib,"${D}"/usr/$(get_libdir)}
		cd -
	fi

	if use sopcast ; then
		exeinto /opt/sopcast
		doexe sp-sc-auth

		dodir /opt/bin
		dosym /opt/{sopcast/sp-sc-auth,bin}
	fi
}
