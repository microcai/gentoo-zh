# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="WPS Office is an office productivity suite, Here is the Chinese version"
HOMEPAGE="https://www.wps.cn/product/wpslinux/"

SRC_URI="
	arm64? ( https://github.com/peeweep/gentoo-go-deps/releases/download/${PN}_${PV}/${PN}_${PV}_arm64.deb )
	amd64? ( https://github.com/peeweep/gentoo-go-deps/releases/download/${PN}_${PV}/${PN}_${PV}_amd64.deb )
	loong? ( https://github.com/peeweep/gentoo-go-deps/releases/download/${PN}_${PV}/${PN}_${PV}_loongarch64.deb )
	mips?	( ${PN}_${PV}_mips64el.deb )
"

S="${WORKDIR}"

LICENSE="WPS-EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~mips"
IUSE="big-endian systemd abi_mips_n64"
REQUIRED_USE="mips? ( !big-endian abi_mips_n64 )"

RESTRICT="strip mirror bindist" # mirror as explained at bug #547372

# Deps got from this (listed in order):
# rpm -qpR wps-office-10.1.0.5707-1.a21.x86_64.rpm
# ldd /opt/kingsoft/wps-office/office6/wps
# ldd /opt/kingsoft/wps-office/office6/wpp
RDEPEND="
	app-arch/bzip2:0
	app-arch/lz4
	app-arch/xz-utils
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error
	dev-libs/libpcre:3
	media-libs/flac
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/tiff-compat:4
	media-libs/libpulse
	net-libs/libasyncns
	net-print/cups
	sys-apps/attr
	sys-apps/dbus
	sys-apps/tcp-wrappers
	sys-apps/util-linux
	sys-libs/libcap
	sys-libs/zlib:0
	virtual/glu
	x11-libs/gtk+:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst
	loong? (
		virtual/loong-ow-compat
	)
"

pkg_nofetch() {
	einfo "Please download WPS Office 2019 For Linux version ${PV} from"
	einfo "    ${HOMEPAGE}"
	einfo "The archive should then be placed into your distfiles directory."
}

src_install() {
	exeinto /usr/bin
	exeopts -m0755
	doexe "${S}"/usr/bin/*

	insinto /usr/share
	doins -r "${S}"/usr/share/{applications,desktop-directories,icons,mime,templates}

	insinto /opt/kingsoft/wps-office
	use systemd || { rm "${S}"/opt/kingsoft/wps-office/office6/libdbus-1.so* || die ; }
	rm "${S}"/opt/kingsoft/wps-office/office6/libstdc++.so* || die
	doins -r "${S}"/opt/kingsoft/wps-office/{office6,templates}

	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et,wpspdf,wpsoffice,promecefpluginhost,transerr,ksolaunch,wpscloudsvr}
}
