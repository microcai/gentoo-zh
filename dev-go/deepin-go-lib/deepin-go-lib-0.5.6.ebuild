# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# EGO_PN="github.com/BurntSushi/xgb github.com/BurntSushi/xgbutil github.com/howeyc/fsnotify gopkg.in/alecthomas/kingpin.v2 github.com/disintegration/imaging"
# 
# inherit golang-vcs

#inherit git-2

DESCRIPTION="Deepin GoLang Library"
HOMEPAGE="https://github.com/linuxdeepin/go-lib"
SRC_URI="https://github.com/linuxdeepin/go-lib/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/howeyc/fsnotify/archive/v0.9.0.tar.gz -> fsnotify-0.9.0.tar.gz
		https://github.com/mattn/go-sqlite3/archive/v1.2.0.tar.gz -> go-sqlite3-1.2.0.tar.gz
		https://github.com/alecthomas/kingpin/archive/v2.2.3.tar.gz -> kingpin-2.2.3.tar.gz
		https://github.com/fsnotify/fsnotify/archive/v1.4.2.tar.gz -> fsnotify-1.4.2.tar.gz"
#		http://packages.linuxdeepin.com/deepin/pool/main/g/golang-gocheck/golang-gocheck_0.0~bzr20131118%2b85.orig.tar.gz -> gocheck.tar.gz"
#EGIT_REPO_URI="https://github.com/disintegration/imaging.git
#			https://github.com/BurntSushi/xgb.git
#			https://github.com/BurntSushi/xgbutil.git
#			https://github.com/go-check/check.git
#			"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		dev-lang/go
		!dev-go/dde-go-essential"

DEPEND="${RDEPEND}
	      dev-vcs/git
	      dev-vcs/bzr"

S=${WORKDIR}

src_prepare() {
		git clone https://github.com/disintegration/imaging.git || die
		git clone https://github.com/BurntSushi/xgb.git || die
		git clone https://github.com/BurntSushi/xgbutil.git || die
		git clone https://github.com/alecthomas/units.git || die
		git clone https://github.com/alecthomas/template.git || die
		git clone https://github.com/golang/image.git || die
		git clone https://github.com/BurntSushi/freetype-go.git || die
		git clone https://github.com/BurntSushi/graphics-go.git
		git clone https://github.com/golang/sys.git || die
		git clone https://github.com/golang/net.git || die

		find ${S}/ | grep '\.git$' | xargs rm -r

		mkdir -p ${WORKDIR}/src/pkg.deepin.io/ \
				${WORKDIR}/src/github.com/BurntSushi/ \
				${WORKDIR}/src/github.com/howeyc/ \
				${WORKDIR}/src/github.com/disintegration/ \
				${WORKDIR}/src/github.com/mattn/ \
				${WORKDIR}/src/launchpad.net/ \
				${WORKDIR}/src/gopkg.in/alecthomas/ \
				${WORKDIR}/src/github.com/alecthomas/ \
				${WORKDIR}/src/github.com/fsnotify/ \
				${WORKDIR}/src/golang.org/x/

		cp -r ${S}/go-lib-${PV}  ${WORKDIR}/src/pkg.deepin.io/lib
		cp -r ${S}/xgb ${WORKDIR}/src/github.com/BurntSushi/
		cp -r ${S}/xgbutil ${WORKDIR}/src/github.com/BurntSushi/
		cp -r ${S}/freetype-go ${WORKDIR}/src/github.com/BurntSushi/
		cp -r ${S}/graphics-go ${WORKDIR}/src/github.com/BurntSushi/
		cp -r ${S}/imaging ${WORKDIR}/src/github.com/disintegration/
		cp -r ${S}/image ${WORKDIR}/src/golang.org/x/
		cp -r ${S}/sys ${WORKDIR}/src/golang.org/x/
		cp -r ${S}/net ${WORKDIR}/src/golang.org/x/
		cp -r ${S}/fsnotify-0.9.0 ${WORKDIR}/src/github.com/howeyc/fsnotify
		cp -r ${S}/go-sqlite3-1.2.0 ${WORKDIR}/src/github.com/mattn/go-sqlite3
#		cp -r ${S}/'~niemeyer'/gocheck/trunk ${WORKDIR}/src/launchpad.net/gocheck
		cp -r ${S}/kingpin-2.2.3 ${WORKDIR}/src/gopkg.in/alecthomas/kingpin.v2
		cp -r ${S}/template ${WORKDIR}/src/github.com/alecthomas/
		cp -r ${S}/units ${WORKDIR}/src/github.com/alecthomas/
		cp -r ${S}/fsnotify-1.4.2 ${WORKDIR}/src/github.com/fsnotify/fsnotify

		export GOPATH=${WORKDIR}
		go get -d -f -u -v launchpad.net/gocheck || die 
#		go get -d -f -u -v gopkg.in/alecthomas/kingpin.v2 
#			  github.com/disintegration/imaging  \
#			  github.com/BurntSushi/xgb \
#			  github.com/BurntSushi/xgbutil \
#			  github.com/howeyc/fsnotify	\
#			  launchpad.net/gocheck \
#			  github.com/mattn/go-sqlite3 || die " get dependent sources failed "

}

src_install() {
	insinto /usr/share/gocode
	doins -r ${WORKDIR}/src
}
