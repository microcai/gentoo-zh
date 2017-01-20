# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5


DESCRIPTION="Essential go sources for DDE"
HOMEPAGE="http://packages.deepin.com/deepin/pool/main/g"
SRC_URI="http://packages.deepin.com/deepin/pool/main/g/golang-golang-x-image-dev/golang-golang-x-image-dev_0.0+git20150226.orig.tar.xz
	      http://packages.deepin.com/deepin/pool/main/g/golang-xgb/golang-xgb_0.0~git20140510.orig.tar.xz
	      http://packages.deepin.com/deepin/pool/main/g/golang-xgbutil/golang-xgbutil_1~git20140610.orig.tar.xz
	      http://packages.deepin.com/deepin/pool/main/g/golang-jamslam-freetype-go/golang-jamslam-freetype-go_0.0~git20140903.orig.tar.xz
	      http://packages.deepin.com/deepin/pool/main/g/golang-go-sqlite3/golang-go-sqlite3_0.0~git20140913.orig.tar.gz
	      http://packages.deepin.com/deepin/pool/main/g/golang-kingpin.v2/golang-kingpin.v2_2.1.0.orig.tar.xz
	      http://packages.deepin.com/deepin/pool/main/g/golang-graphics-go/golang-graphics-go_0.0~git20140903.orig.tar.xz
	      http://packages.deepin.com/deepin/pool/main/g/golang-gocheck/golang-gocheck_0.0~bzr20131118%2b85.orig.tar.gz
	      http://packages.deepin.com/deepin/pool/main/g/golang-fsnotify.howeyc/golang-fsnotify.howeyc_0.9.0.orig.tar.xz
	      "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc[go]
		dev-lang/go
	      "
# 	      
# src_prepare() {
# 		
# }