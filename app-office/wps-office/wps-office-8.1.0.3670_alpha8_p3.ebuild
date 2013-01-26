# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit fdo-mime font unpacker versionator


MY_PV="$(get_version_component_range 1-4)"
MY_A="$(get_version_component_range 5)"
MY_ALPHA=${MY_A/alpha/a}

DESCRIPTION="WPS Office is an office productivity suite. This is an ALPHA
package. Use it at your own risk."
HOMEPAGE="http://www.wps.cn"

if [ -z "$(get_version_component_range 6)" ]; then
	SRC_URI="http://wdl.cache.ijinshan.com/wps/download/Linux/unstable/${PN}_${MY_PV}~${MY_ALPHA}_i386.deb"
else
	MY_SP="$(get_version_component_range 6)"
	SRC_URI="http://wdl.cache.ijinshan.com/wps/download/Linux/unstable/${PN}_${MY_PV}~${MY_ALPHA}${MY_SP}_i386.deb"
fi

RESTRICT="strip mirror"
LICENSE="WPS-EULA"
KEYWORDS=""
SLOT="alpha"
IUSE="corefonts"

RDEPEND="
	x86? (
		app-arch/bzip2
		dev-libs/expat
		dev-libs/libffi
		dev-libs/glib:2
		x11-libs/libICE
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXdmcp
		x11-libs/libXrender
		x11-libs/libXext
		x11-libs/libSM
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		media-libs/libmng
		sys-libs/glibc:2.2
		sys-libs/e2fsprogs-libs
		sys-libs/zlib
		sys-devel/gcc
	)
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		sys-devel/gcc[multilib]
		sys-libs/glibc[multilib]
	)
	corefonts? ( media-fonts/corefonts )
	media-libs/libpng:1.2
	net-nds/openldap
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	sys-devel/binutils"

S=${WORKDIR}

src_install() {
	exeinto /usr/bin
	exeopts -m0755
	doexe ${S}/usr/bin/wps
	doexe ${S}/usr/bin/wpp
	doexe ${S}/usr/bin/et

	insinto /usr
	doins -r ${S}/usr/share

	insinto /
	doins -r ${S}/opt
	fperms 0755 /opt/kingsoft/wps-office/office6/wps
	fperms 0755 /opt/kingsoft/wps-office/office6/wpp
	fperms 0755 /opt/kingsoft/wps-office/office6/et
}

pkg_postinst() {
	font_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
