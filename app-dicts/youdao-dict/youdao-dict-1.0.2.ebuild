# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="有道词典"
HOMEPAGE="http://cidian.youdao.com/index-linux.html"
SRC_URI="amd64? ( http://codown.youdao.com/cidian/linux/youdao-dict_${PV}~binary_amd64.tar.gz )
 x86? ( http://codown.youdao.com/cidian/linux/youdao-dict_${PV}~binary_i386.tar.gz )
"

LICENSE="Youdao"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RESTRICT_PYTHON_ABIS="3.*"

RDEPEND=">=dev-lang/python-3.0.0
dev-python/PyQt5
dev-python/requests
dev-python/pillow
dev-python/python3-xlib
app-text/tesseract[linguas_zh_CN,linguas_zh_TW]
"

DEPEND="${RDEPEND}"
S=${WORKDIR}

src_compile(){
  rm license_ch.txt copyright README.md install.sh
}

src_install(){
  dodir /usr/share/youdao-dict
  insinto /usr/share/youdao-dict
  doins -r ${S}/src/*
  fperms 0755 /usr/share/youdao-dict/main.py
  fperms 0755 /usr/share/youdao-dict/youdao-dict-backend.py

  dodir /usr/share/icons/hicolor
  insinto /usr/share/icons/hicolor
  doins -r ${S}/data/hicolor/*
  
  dodir /usr/share/dbus-1/services
  insinto /usr/share/dbus-1/services
  doins ${R}/data/com.youdao.backend.service

  dodir /usr/share/applications
  insinto /usr/share/applications
  doins ${R}/data/youdao-dict.desktop
	
  dodir /etc/xdg/autostart
  insinto /etc/xdg/autostart
  doins ${S}/data/youdao-dict-autostart.desktop

  dosym /usr/share/youdao-dict/main.py /usr/bin/youdao-dict

}
