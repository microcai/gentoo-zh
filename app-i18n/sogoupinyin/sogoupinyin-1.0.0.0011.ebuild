# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Sogou Pinyin input method."
HOMEPAGE="http://pinyin.sogou.com/linux/"
SRC_URI="amd64? ( http://download.ime.sogou.com/1397738329/sogou_pinyin_linux_${PV}_amd64.deb )
 x86? ( http://download.ime.sogou.com/1397738329/sogou_pinyin_linux_${PV}_i386.deb )
"

LICENSE="Fcitx-Sogou"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8[qt4,X,dbus]
!app-i18n/fcitx-qimpanel
dev-qt/qtdeclarative:4
dev-qt/qtgui:4
!app-i18n/fcitx-sogoupinyin"
DEPEND="${RDEPEND}"
S=${WORKDIR}

src_compile(){
  tar xf ${WORKDIR}/data.tar.xz
  rm control.tar.gz  data.tar.xz  debian-binary
#  rm -rf usr/share/fcitx-qimpanel
  rm -rf usr/share/upstart
}

src_install(){
  dodir /usr/lib/fcitx
  insinto /usr/lib/fcitx
  insopts -m0755
  doins ${S}/usr/lib/*-linux-gnu/fcitx/*
  dodir /usr/share/mime-info
  insinto /usr/share/mime-info
  install -D ${S}/usr/lib/mime/packages/fcitx-ui-qimpanel fcitx-ui-qimpanel.keys
  dodir /usr/share
  insinto /usr/share
  doins -r ${S}/usr/share/*

  dodir /usr/bin
  insinto /usr/bin
  doins  ${S}/usr/bin/*
  dodir /etc/xdg/autostart
  insinto /etc/xdg/autostart
  doins ${S}/etc/xdg/autostart/*
}

pkg_postinst(){
	einfo
	einfo "After install the fcitx-sogoupinyin, a restart of fcitx is"
	einfo "expected."
	einfo
	einfo "if you see 请启用fcitx-qimpanel面板程序，以便更好的享受搜狗输入法！"
	einfo "relogin to your desktop, or just start fcitx-qimpanal"
}
