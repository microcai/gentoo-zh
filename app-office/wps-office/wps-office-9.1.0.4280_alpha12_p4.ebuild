# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime font unpacker versionator


MY_PV="$(get_version_component_range 1-4)"
MY_V="$(get_version_component_range 5)"

if [ -z "$(get_version_component_range 6)" ]; then
	MY_SP=""
else
	MY_SP="$(get_version_component_range 6)"
fi

case ${PV} in
	*_alpha*)
		KEYWORDS="~amd64 ~x86"
		MY_VV=${MY_PV}~${MY_V/alpha/a}${MY_SP}
		;;
	*_beta*)
		KEYWORDS="amd64 x86"
		MY_VV=${MY_PV}~${MY_V/beta/b}${MY_SP}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac

DESCRIPTION="WPS Office is an office productivity suite. This is an ALPHA
package. Use it at your own risk."
HOMEPAGE="http://www.wps.cn"

MY_PN=kingsoft-office

SRC_URI="http://kdl.cc.ksosoft.com/wps-community/${MY_PN}_${MY_VV}_i386.deb
         http://wps-community.org/download/tools/wps_merge_old_conf.sh"

SLOT="0"
RESTRICT="strip mirror"
LICENSE="WPS-EULA"
IUSE="corefonts +sharedfonts"

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
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-qtlibs
		app-emulation/emul-linux-x86-xlibs
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

	cp "${DISTDIR}/wps_merge_old_conf.sh" "${S}/usr/bin"
    doexe ${S}/usr/bin/wps_merge_old_conf.sh

	if ! use sharedfonts; then
		insinto /opt/kingsoft/wps-office/office6/fonts
		doins -r ${S}/usr/share/fonts/wps-office/*
		rm -rf ${S}/usr/share/fonts || die
	fi

	insinto /usr
	doins -r ${S}/usr/share

	insinto /
	doins -r ${S}/opt
	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et}
}

pkg_postinst() {
	use sharedfonts && font_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	ewarn
	ewarn "Please run wps_merge_old_conf.sh before you use (don't run it as root)."
	ewarn "Config File Formats changed in a12p1. If you upgrade from earlier version,"
	ewarn "Please migrate your personal configs."
	ewarn "Run wps_merge_old_conf.sh before you use (don't run it as root)."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
