# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~9f146c62a7"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+branding"

RDEPEND="x11-libs/deepin-ui
		dev-python/xappy
		>=gnome-base/gnome-settings-daemon-3.8
		dev-python/deepin-gsettings"
DEPEND=""
S=${WORKDIR}/${PN}-${MY_VER}

src_prepare() {
	sed -i 's|;deepin$|;deepin;|g' ${S}/debian/${PN}.desktop
	sed -i 's|;Settings$|;Settings;|g' ${S}/debian/${PN}.desktop
	use branding && cp ${FILESDIR}/gentoo-logo.png ${S}/app_theme/dark_grey/image/system_information/logo.png
}

src_install() {

	insinto "/usr/share/"
	doins -r ${S}/locale
	rm ${D}/usr/share/locale/*.po* 

	insinto "/usr/share/${PN}"
	doins -r ${S}/app_theme  ${S}/dss ${S}/image ${S}/locale ${S}/search_db ${S}/skin
	fperms 0755 -R /usr/share/${PN}/dss/
	rm ${D}/usr/share/${PN}/locale/*.po* 

	#dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}
	echo "#!/bin/sh" > ${PN}
	echo "python2 /usr/share/${PN}/dss/main.py" >> ${PN}
	dobin ${PN}

	insinto "/usr/share/applications"
	doins ${S}/debian/${PN}.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
