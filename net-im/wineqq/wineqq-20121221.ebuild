# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Tencent QQ for Linux by longine"
HOMEPAGE="http://www.longene.org/"
SRC_URI="http://www.longene.org/download/WineQQ2012-${PV}-Longene.deb
		 zd423? (
			 http://www.xpxt.net/plus/download.php?open=2&id=3306&uhash=49dca8c63ef646ffca31e92f -> QQIntl1.6_Dmcl.exe
         )
"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-wine zd423"

RDEPEND="amd64? (
		app-emulation/emul-linux-x86-gtklibs
        )

	system-wine? (
		>=app-emulation/wine-1.6_rc3[abi_x86_32,-abi_x86_x32,-abi_x86_64,fontconfig,mp3,truetype,X,nls,xml] 
	)
	!amd64? ( x11-libs/gtk+:2 )

	zd423? (
		app-arch/p7zip-nsis
		app-arch/unrar
	)
"

RESTRICT="mirror strip"

QA_PRESTRIPPED="opt/linuxqq/qq"

S=$WORKDIR

src_install() {
	tar xzvf data.tar.gz -C ${D}/	

	if use zd423 ; then
		cd ${D}
		cd opt/longene/qq2012

		7z-nsis x -osource ${DISTDIR}/QQIntl1.6_Dmcl.exe
		mkdir final

		cp source/{af.xml.txd,app.xml.txd,common.xml.txd,gf-config-postlogin.xml,gf-config.xml,kernel.xml.txd,platform1033.tpc,platform1036.tpc,Timwp_gf.tpc,Timwp.xml.txd,xgui.xml} final

		cp -R ./source/\$[31]/Bin final/
		cp -R ./source/\$[31]/I18N final/
		cp -R ./source/\$[31]/Misc final/
		cp -R ./source/\$[31]/Plugin final/
		cp -R ./source/\$[31]/Resource.1.75.2739 final/

		rm -rf source

		tar -xvf qq2012.tar.gz
		rm qq2012.tar.gz
		rm -rf "qq2012/drive_c/Program Files/Tencent/QQ/"
		mv final "qq2012/drive_c/Program Files/Tencent/QQ"
		tar -cvzf qq2012.tar.gz qq2012
	fi

	chmod 755 ${D}/opt
	chmod 755 ${D}/usr
	cp ${D}/opt/longene/qq2012/qq2012-test.desktop ${D}/usr/share/applications/
	if use system-wine ; then
	    cp -f ${FILESDIR}/qq2012.sh ${D}/opt/longene/qq2012/qq2012.sh
	    rm -rf ${D}/opt/longene/qq2012/wine
	fi
}

pkg_postinst() {
	elog
	elog "Some user reported that some fonts could not display."
	elog "It was a system environment related issue."
	elog "If you have that issue, check Issue #92 (https://github.com/microcai/gentoo-zh/issues/92) to find out possible solution."
	elog
	elog "You need to rm -rf ~/.longene after switching to/from zd423 USE Flag."
	elog
}
