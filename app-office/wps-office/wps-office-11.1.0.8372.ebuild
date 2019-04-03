# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eapi7-ver gnome2-utils xdg

MY_PV="$(ver_cut 4)"
echo $MY_PV

DESCRIPTION="WPS Office is an office productivity suite"
HOMEPAGE="http://www.wps.cn/product/wpslinux/ http://wps-community.org/"

KEYWORDS="~amd64 ~x86"

SRC_URI="
		amd64? ( https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/${MY_PV}/${PN}_${PV}_amd64.deb )
		x86? ( https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/${MY_PV}/${PN}_${PV}_i386.deb )
"

SLOT="0"
RESTRICT="strip mirror" # mirror as explained at bug #547372
LICENSE="WPS-EULA"
IUSE=""

# Deps got from this (listed in order):
# rpm -qpR wps-office-10.1.0.5707-1.a21.x86_64.rpm
# ldd /opt/kingsoft/wps-office/office6/wps
# ldd /opt/kingsoft/wps-office/office6/wpp
RDEPEND="
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libxcb
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		dev-libs/glib:2
		sys-libs/zlib:0
		net-print/cups
		media-libs/libpng:1.2
		virtual/glu

		dev-libs/libpcre:3
		dev-libs/libffi
		media-sound/pulseaudio
		app-arch/bzip2:0
		media-libs/libpng:0
		dev-libs/expat
		sys-apps/util-linux
		dev-libs/libbsd
		x11-libs/libXau
		x11-libs/libXdmcp
		sys-apps/dbus
		x11-libs/libXtst
		sys-apps/tcp-wrappers
		media-libs/libsndfile
		net-libs/libasyncns
		dev-libs/libgcrypt:0
		app-arch/xz-utils
		app-arch/lz4
		sys-libs/libcap
		media-libs/flac
		media-libs/libogg
		media-libs/libvorbis
		dev-libs/libgpg-error
		sys-apps/attr
"
DEPEND=""

S="${WORKDIR}"

#src_prepare() {
#       default
		# We need to drop qtwebkit bundled lib completely because it causes
		# crashes in *some* setups (https://bugs.gentoo.org/647950)
#       rm -f "${S}"/opt/kingsoft/wps-office/office6/libQtWebKit* || die
#}

src_unpack() {
	default_src_unpack
	unpack ./data.tar.xz
}

src_install() {
		exeinto /usr/bin
		exeopts -m0755
		doexe "${S}"/usr/bin/wps
		doexe "${S}"/usr/bin/wpp
		doexe "${S}"/usr/bin/et

		insinto /usr/share
		doins -r "${S}"/usr/share/{applications,icons,mime}

		insinto /opt/kingsoft/wps-office
		doins -r "${S}"/opt/kingsoft/wps-office/office6
		doins -r "${S}"/opt/kingsoft/wps-office/templates

		# Don't allow wpsoffice to run, beacause it stops user to logout
		fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et,promecefpluginhost,wpspdf}
}

pkg_preinst() {
		xdg_pkg_preinst
		gnome2_icon_savelist
}

pkg_postinst() {
		xdg_pkg_postinst
		gnome2_icon_cache_update
}

pkg_postrm() {
		xdg_pkg_postrm
		gnome2_icon_cache_update
}
