# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2-utils eutils

MY_PV="2010Beta1"
SRC_URI_BASE="http://interface-club.12530.com/update/Linux/"

DESCRIPTION="An online music client"
HOMEPAGE="http://music.10086.cn/newweb/zq/2009/migu_music_client/default/_/_/_/_/_/_/p.html"
SRC_URI="
	qt-static? ( ${SRC_URI_BASE}${PN}_${MY_PV}.bin )
	!qt-static? ( ${SRC_URI_BASE}${PN}_noqtlib_${MY_PV}.bin )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer qt-static"

RESTRICT="mirror"

RDEPEND="
	amd64? (
		!qt-static? ( app-emulation/emul-linux-x86-qtlibs )
		sys-devel/gcc[multilib]
		sys-libs/glibc[multilib] )
	x86? (
		gstreamer? (
			media-libs/gst-plugins-bad
			media-libs/gst-plugins-ugly
			media-plugins/gst-plugins-ffmpeg
			x11-libs/gtk+ )
		!qt-static? (
			media-sound/phonon[gstreamer=]
			dev-qt/qtcore:4
			dev-qt/qtdbus:4
			dev-qt/qtgui:4[accessibility,dbus]
			dev-qt/qtsql:4[sqlite]
			dev-qt/qtwebkit:4
			dev-qt/qtxmlpatterns:4 ) )
		sys-devel/gcc
		sys-libs/glibc"
DEPEND=""

S="${WORKDIR}"

pkg_setup() {
	if use amd64 && use gstreamer; then
		ewarn
		ewarn "Amd64 hasn't gstreamer support"
		die "Please disable gstreamer USE flag"
	fi
}

src_unpack() {
	sed -n -e '1,/^exit 0$/!p' "${DISTDIR}"/${A} > "${T}"/${A}.tar.gz
	tar xf "${T}"/${A}.tar.gz -C "${T}" || die
	tar xf "${T}"/MiguMusicInstaller/${PN}.tar.gz -C "${S}" || die
}

src_prepare() {
	find . -type d -name .svn -exec rm -fR {} \; >/dev/null 2>&1
	rm ${PN}.sh Readme Resource/uninstaller.png uninstaller*
}

src_install() {
	dodir /opt/${PN}
	cp -R * "${T}"/MiguMusicInstaller/libQt* "${D}"/opt/${PN}

	insinto /opt/bin
	doins "${FILESDIR}"/${PN}
	fperms +x /opt/bin/${PN}

	domenu "${FILESDIR}"/${PN}.desktop
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
