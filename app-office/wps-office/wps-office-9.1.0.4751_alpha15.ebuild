# Copyright 1999-2014 Gentoo Foundation
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
		KEYWORDS="-* ~amd64 ~x86"
		MY_BRANCH=${MY_V/alpha/a}
		;;
	*_beta*)
		KEYWORDS="-* amd64 x86"
		MY_BRANCH=${MY_V/beta/b}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac
MY_VV=${MY_PV}~${MY_BRANCH}${MY_SP}

DESCRIPTION="WPS Office is an office productivity suite. This is an ALPHA
package. Use it at your own risk."
HOMEPAGE="http://www.wps.cn"

SRC_URI="http://kdl.cc.ksosoft.com/wps-community/download/${MY_BRANCH}/${PN}_${MY_VV}_i386.deb"

SLOT="0"
RESTRICT="strip mirror"
LICENSE="WPS-EULA"
IUSE="+abi_x86_32 corefonts +sharedfonts"
REQUIRED_USE="abi_x86_32"  # for now; will add abi_x86_64 once available

NATIVE_DEPEND="
		app-arch/bzip2
		dev-libs/expat
		dev-libs/glib:2
		dev-libs/libffi
		dev-libs/libxml2:2
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		media-libs/glu
		media-libs/gst-plugins-base:0.10
		media-libs/gstreamer:0.10
		media-libs/libpng:1.2
		virtual/opengl
		media-libs/tiff:3
		sys-apps/util-linux
		sys-devel/gcc
		sys-libs/glibc
		sys-libs/zlib
		x11-libs/libdrm
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libXxf86vm"

RDEPEND="
	!amd64? (
		${NATIVE_DEPEND}
	)
	amd64? (
		abi_x86_32? (
			sys-devel/gcc[multilib]
			sys-libs/glibc[multilib]
			( || (
				app-emulation/emul-linux-x86-baselibs
				(
					app-arch/bzip2[abi_x86_32]
					dev-libs/expat[abi_x86_32]
					dev-libs/glib:2[abi_x86_32]
					dev-libs/libffi[abi_x86_32]
					dev-libs/libxml2:2[abi_x86_32]
					media-libs/libpng:1.2[abi_x86_32]
					media-libs/tiff:3[abi_x86_32]
					sys-apps/util-linux[abi_x86_32]
					sys-libs/zlib[abi_x86_32]
				)
			) )
			( || (
				app-emulation/emul-linux-x86-medialibs
				(
					media-libs/gst-plugins-base:0.10[abi_x86_32]
					media-libs/gstreamer:0.10[abi_x86_32]
				)
			) )
			( || (
				app-emulation/emul-linux-x86-opengl
				(
					media-libs/glu[abi_x86_32]
					virtual/opengl[abi_x86_32]
					x11-libs/libdrm[abi_x86_32]
				)
			) )
			( || (
				app-emulation/emul-linux-x86-xlibs
				(
					media-libs/fontconfig:1.0[abi_x86_32]
					media-libs/freetype:2[abi_x86_32]
					x11-libs/libICE[abi_x86_32]
					x11-libs/libSM[abi_x86_32]
					x11-libs/libX11[abi_x86_32]
					x11-libs/libXau[abi_x86_32]
					x11-libs/libxcb[abi_x86_32]
					x11-libs/libXdamage[abi_x86_32]
					x11-libs/libXdmcp[abi_x86_32]
					x11-libs/libXext[abi_x86_32]
					x11-libs/libXfixes[abi_x86_32]
					x11-libs/libXrender[abi_x86_32]
					x11-libs/libXxf86vm[abi_x86_32]
				)
			) )
		)
	)

	corefonts? ( media-fonts/corefonts )
	net-nds/openldap
	dev-db/sqlite:3"

DEPEND=""

S=${WORKDIR}

src_install() {
	exeinto /usr/bin
	exeopts -m0755
	doexe ${S}/usr/bin/wps
	doexe ${S}/usr/bin/wpp
	doexe ${S}/usr/bin/et

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
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
