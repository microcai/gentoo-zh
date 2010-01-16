# Copyright 1999-2009 Gentoo Foundation
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
	usr/bin/sp-sc-auth
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
		#emake || die "emake failed" # use libppswrapper
	fi
}

src_install() {
	insinto /usr/bin

	if use pplive ; then
		doins xpplive
		fperms 0755 /usr/bin/xpplive
	fi

	if use pps ; then
		cd "${S}"/ppstream
		#emake DESTDIR="${D}" install || die "install failed"

		use x86 || multilib_toolchain_setup x86
		mv {lib,"${D}"/usr/$(get_libdir)}
		cd -
	fi

	if use sopcast ; then
		doins sp-sc-auth
		fperms 0755 /usr/bin/sp-sc-auth
	fi
}
