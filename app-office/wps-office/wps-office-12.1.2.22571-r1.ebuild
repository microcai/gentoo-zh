# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="WPS Office is an office productivity suite, Here is the Chinese version"
HOMEPAGE="https://www.wps.cn/product/wpslinux/"

SRC_URI="
	amd64?	( https://dogfood.gnupg.uk/wps302/${PV}/amd64 -> ${PN}_${PV}_amd64.deb )
"

S="${WORKDIR}"

LICENSE="WPS-EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RESTRICT="strip mirror bindist" # mirror as explained at bug #547372

# dpkg --info wps-office_12.1.2.22571_amd64.deb
RDEPEND="
	app-arch/bzip2
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glu
	net-print/cups
	sys-libs/glibc
	x11-libs/libSM
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/libXrender
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
	# QA Notice: Symbolic link /opt/kingsoft/wps-office/office6/libbz2.so
	# points to /opt/kingsoft/wps-office/office6/libbz2.so.1.0.4 which does not exist.
	rm "${S}"/opt/kingsoft/wps-office/office6/libbz2.so || die
	doins -r "${S}"/opt/kingsoft/wps-office/{office6,templates}

	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et,wpspdf,wpsoffice,promecefpluginhost,transerr,ksolaunch,wpscloudsvr}
}
