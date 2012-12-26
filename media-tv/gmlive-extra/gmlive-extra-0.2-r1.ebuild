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
IUSE="+pplive +pps"

DEPEND=""
RDEPEND=""

RESTRICT="primaryuri"

QA_PRESTRIPPED="
	usr/lib32/libppsvodnet.so
	usr/lib32/libppsvodres.so.0
	usr/lib32/libppsfds.so
	usr/lib32/libppsbase.so.0
	usr/lib32/libppssg.so.0.1.784
	usr/lib32/libppsapi.so
	usr/lib32/libppsvodres.so
	usr/lib32/libppsvodnet.so.0
	usr/lib32/libppsbase.so
	usr/lib32/libppssg.so
	usr/lib32/libppsfds.so.0.1.784
	usr/lib32/libppssg.so.0
	usr/lib32/libppsbase.so.0.1.784
	usr/lib32/libppsvodnet.so.0.1.784
	usr/lib32/libppsfds.so.0
	usr/lib32/libppsapi.so.0
	usr/lib32/libppsapi.so.0.1.784
	usr/lib32/libppsvodres.so.0.1.784"
QA_TEXTRELS="
	usr/lib32/libppsvodnet.so
	usr/lib32/libppsbase.so.0
	usr/lib32/libppsapi.so
	usr/lib32/libppsvodnet.so.0
	usr/lib32/libppsbase.so
	usr/lib32/libppsbase.so.0.1.784
	usr/lib32/libppsvodnet.so.0.1.784
	usr/lib32/libppsapi.so.0
	usr/lib32/libppsapi.so.0.1.784"

src_install() {
	insinto /usr/bin

	if use pps ; then
		doins xpps
		fperms 4755 /usr/bin/xpps

		use x86 || multilib_toolchain_setup x86
		dodir /usr
		tar xvf lib_pps.tar.gz
		mv {lib,"${D}"/usr/$(get_libdir)}
	fi

	if use pplive ; then
		doins xpplive
		fperms 0755 /usr/bin/xpplive
	fi
}
