# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games

if use amd64 ; then
MY_P=TroubledWater_x64
MY_PATCH=${PV}_x64
elif use x86 ; then
MY_P=TroubledWater
MY_PATCH=${PV}
fi

S="${WORKDIR}/${MY_P}"

DESCRIPTION="国产Linux网游《时空浩劫》"
HOMEPAGE="http://113.105.223.84/bbs/"
SRC_URI="amd64? ( mirror://troubledwater/download/TroubledWater_x64.tar.gz 
			mirror://troubledwater/download/${PV}_x64.tar.gz )
	   x86? ( mirror://troubledwater/download/TroubledWater.tar.gz
		    mirror://troubledwater/download/${PV}.tar.gz ) "

RESTRICT="strip"

LICENSE="freeware"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	   media-libs/openal
	   dev-libs/libpcre
	   media-libs/libvorbis
	   virtual/opengl
	   dev-libs/libffi
	   sys-apps/util-linux
	   sys-libs/zlib
	   dev-libs/glib
"

pkg_nofetch(){
	# manul fetch, because we think it's fater for users to fetch it manuly

	einfo "Warning , the source file is hurge, please manully download it from"
	einfo " http://113.105.223.84/bbs/viewtopic.php?f=14&t=169 "
	if use amd64 ; then
	einfo "Download TroubledWater_x64.tar.gz and 1009_64.tar.gz"
	elif use x86 ; then
	einfo "Download TroubledWater.tar.gz and 1009.tar.gz"
	fi
	einfo "and put them into ${DISTDIR}"
}


src_unpack(){
	unpack ${MY_P}.tar.gz
	cd ${MY_P}
	unpack ${MY_PATCH}.tar.gz
}


src_install(){
	dodir /usr/games/bin
	cp -r ${S} ${D}/usr/games/${PN}

	# add startup script
	cp ${FILESDIR}/skwx_unx ${D}/usr/games/bin/skwx_unx
	chown games:games ${D}/usr/games/bin/skwx_unx
	chmod 0755 ${D}/usr/games/bin/skwx_unx

	#add desktop icon
	insinto /usr/share/applications/
	doins	${FILESDIR}/skwx.desktop
}

