# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Netease cloud music player"
HOMEPAGE="http://music.163.com"
COMMON_URI="http://s1.music.126.net/download/pc"
SRC_URI="amd64? ( ${COMMON_URI}/${PN}_${PV}-${PR:1}_amd64.deb )
           x86? ( ${COMMON_URI}/${PN}_${PV}-${PR:1}_i386.deb )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtkstyle hidpi"
RESTRICT="mirror strip"

RDEPEND=">=media-libs/alsa-lib-1.0.16
>=dev-libs/atk-1.12.4
>=sys-libs/glibc-2.14
>=x11-libs/cairo-1.6.0
media-libs/libcue
>=net-print/cups-1.4.0
>=sys-apps/dbus-1.9.14
>=dev-libs/expat-2.0.1
>=media-libs/fontconfig-2.11.94
>=media-libs/freetype-2.4.2
>=sys-devel/gcc-5.2
>=x11-libs/gdk-pixbuf-2.22.0
>=dev-libs/glib-2.37.3
>=x11-libs/gtk+-2.24.0
>=dev-libs/nspr-4.9
>=dev-libs/nss-3.13.4
>=x11-libs/pango-1.14.0
>=dev-qt/qtcore-5.5.0
>=dev-qt/qtdbus-5.0.2
>=dev-qt/qtgui-5.0.2
gtkstyle? ( >=dev-qt/qtgui-5.0.2[gtkstyle] )
>=dev-qt/qtnetwork-5.0.2
>=dev-qt/qtwidgets-5.0.2
>=dev-qt/qtx11extras-5.1.0
>=dev-qt/qtxml-5.0.2
>=dev-db/sqlite-3.5.9
>=dev-libs/openssl-1.0.0
>=media-libs/taglib-1.9.1
>=x11-libs/libX11-1.4.99.1
>x11-libs/libXcursor-1.1.2
x11-libs/libXext
x11-libs/libXfixes
>=x11-libs/libXi-1.2.99.4
>=x11-libs/libXrandr-1.2.99.2
x11-libs/libXrender
x11-libs/libXScrnSaver
x11-libs/libXtst
>=sys-libs/zlib-1.2.3.3
media-plugins/gst-plugins-meta:1.0
dev-qt/qtsql[sqlite]
>=dev-qt/qtmultimedia-5.0.2[widgets,gstreamer]"
DEPEND="${RDEPEND}"
S=${WORKDIR}

src_compile(){
  tar xf ${S}/data.tar.xz
  rm control.tar.gz data.tar.xz debian-binary
}

src_install(){
  insinto /
  doins -r ${S}/usr

  dodir /usr/bin
  exeinto /usr/bin
  doexe ${FILESDIR}/${PN}

  dodir /usr/lib/${PN}
  exeinto /usr/lib/${PN}
  doexe ${S}/usr/lib/${PN}/chrome-sandbox
  doexe ${S}/usr/lib/${PN}/netease-cloud-music

  # fix HiDPI screen display
  if use hidpi; then
    dodir /usr/lib/${PN}
    exeinto /usr/lib/${PN}
    doexe ${FILESDIR}/${PN}-hidpi
  fi
}
