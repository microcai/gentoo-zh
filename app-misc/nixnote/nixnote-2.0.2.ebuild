# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils versionator


if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/baumgarr/${PN}2.git"
else
	SRC_URI="https://github.com/baumgarr/${PN}2/archive/v${PV}.tar.gz -> ${PN}2-${PV}.tar.gz"
	S="${WORKDIR}/${PN}2-${PV}"
fi

SLOT="2"
DESCRIPTION="Nixnote - A clone of Evernote for Linux"
HOMEPAGE="http://sourceforge.net/projects/nevernote/"

LICENSE="GPL-2"
[[ ${PV} == *9999* ]] || KEYWORDS="~amd64 ~x86"
IUSE="qt4 +qt5 hunspell webcam"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="dev-libs/boost
		  net-misc/curl
	      
	      qt4? (
		      app-text/poppler[qt4]
		      dev-qt/qtwebkit:4
		      dev-qt/qtcore:4
		      dev-qt/qtgui:4
		      dev-qt/qtsql:4
			  dev-qt/qtscript:4
	      )
	      qt5? (
		      app-text/poppler[qt5]
		      dev-qt/qtwebkit:5
		      dev-qt/qtcore:5
		      dev-qt/qtgui:5
		      dev-qt/qtsql:5
			  dev-qt/qtxml:5
			  dev-qt/qtnetwork:5
			  dev-qt/qtwidgets:5
			  dev-qt/qtprintsupport:5
			  dev-qt/qtdbus:5
			  dev-qt/qtdeclarative:5
	      )

		  hunspell? ( app-text/hunspell )
		  
		  webcam?  ( media-libs/opencv:0= )
		"
RDEPEND="${DEPEND}
		app-text/htmltidy"

src_prepare() {

	QT_SELECT=qt5 lupdate -pro NixNote2.pro -no-obsolete || die
	QT_SELECT=qt5 lrelease NixNote2.pro || die
	
}

src_configure() {
	if use qt4; then
		eqmake4 PREFIX=/usr  NixNote2.pro

		if use hunspell; then
			cd ${S}/plugins/hunspell
			eqmake4 Hunspell.pro
	
			cd ${S}
		fi
		if use webcam; then
			cd ${S}/plugins/webcam
			eqmake4 WebCam.pro

			cd ${S}
		fi
	fi
	if use qt5; then
		eqmake5 PREFIX=/usr NixNote2.pro
		
		if use hunspell; then
			cd ${S}/plugins/hunspell
			eqmake5 Hunspell.pro

			cd ${S}
		fi
		if use webcam; then
			cd ${S}/plugins/webcam
			eqmake5 WebCam.pro

			cd ${S}
		fi
	fi
}

src_compile() {
	emake || die "build Nixnote failed"

	if use hunspell; then
		cd ${S}/plugins/hunspell
		emake || die "plugin Hunspell build failed"

		cd ${S}
	fi
	if use webcam; then
		cd ${S}/plugins/webcam
		emake || die "plugin WebCam build failed"
		
		cd ${S}
	fi

}
src_install() {
	emake INSTALL_ROOT=${D} install

	dodoc -r changelog.txt license.html shortcuts*.txt theme.ini

	rm -r ${D}/usr/share/nixnote2/translations/*.ts
	
	if use hunspell; then
		insinto /usr/$(get_libdir)/nixnote2
		doins plugins/libhunspellplugin.so
	fi
	if use webcam; then
		insinto /usr/$(get_libdir)/nixnote2
		doins plugins/libwebcamplugin.so
	fi
	
	doman ${S}/man/nixnote2.1

}
