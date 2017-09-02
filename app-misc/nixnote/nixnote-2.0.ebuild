# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils versionator

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/baumgarr/${PN}2.git"
else
	MY_PV="$(replace_version_separator 2 '-')"
	SRC_URI="https://github.com/baumgarr/${PN}2/archive/v${MY_PV}.tar.gz -> ${PN}2-${MY_PV}.tar.gz"
	S="${WORKDIR}/${PN}2-${MY_PV}"
fi

SLOT="2" 
DESCRIPTION="Nixnote - A clone of Evernote for Linux"
HOMEPAGE="http://sourceforge.net/projects/nevernote/"

LICENSE="GPL-2"
[[ ${PV} == *9999* ]] || KEYWORDS="~amd64 ~x86"
IUSE="qt4 qt5 +opencv3"

REQUIRED_USE="^^ ( qt4 qt5 )
		      qt5? ( opencv3 )
		      "

DEPEND="dev-libs/boost
	      app-text/hunspell
	      
	      qt4? (
		      app-text/poppler[qt4]
		      dev-qt/qtwebkit:4
		      dev-qt/qtcore:4
		      dev-qt/qtgui:4
		      dev-qt/qtsql:4
	      )
	      qt5? (
		      app-text/poppler[qt5]
		      dev-qt/qtwebkit:5
		      dev-qt/qtcore:5
		      dev-qt/qtgui:5
		      dev-qt/qtsql:5
	      )
		  opencv3? ( =media-libs/opencv-3* )
		  !opencv3? ( media-libs/opencv:0/2.4 )
	      "
RDEPEND="${DEPEND}
		app-text/htmltidy"

src_prepare() {
        
	# fix VideoCapture undefined reference error with opencv-3
	if use opencv3; then
		sed -i 's/LIBS += /LIBS +=  -lopencv_videoio/g' NixNote2.pro
		sed -i '/\#include "opencv\/cv.h"/i\#include "opencv2\/videoio.hpp"' dialog/webcamcapturedialog.h
	fi
	
	lupdate -pro NixNote2.pro -no-obsolete || die
	lrelease NixNote2.pro || die
	
	if use qt4; then
		eqmake4 NixNote2.pro
	fi
	if use qt5; then
		eqmake5 NixNote2.pro
	fi
}

src_install() {
	insinto /usr/share/nixnote2
	doins -r help images java qss translations changelog.txt license.html shortcuts.txt *.ini

	rm -r ${D}/usr/share/nixnote2/translations/*.ts
	
	dobin nixnote2
	
	insinto /usr/share/applications
	doins nixnote2.desktop
	
	doman ${S}/man/nixnote2.1

}
