# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

MY_VER=$(get_version_component_range 1)+git$(get_version_component_range 2)
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin Media Player."
HOMEPAGE="https://github.com/linuxdeepin/deepin-media-player"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/deepin-ui-1.201209101328
	sci-libs/scipy
	dev-python/formencode
	media-video/mplayer2"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${PN}-${MY_VER}
src_prepare() {
	rm -rf debian || die
	rm locale/*.po* 
}

src_install() {
	dodoc AUTHORS ChangeLog 

	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/app_theme ${S}/skin
	fperms 0755 -R /usr/share/${PN}/src/

	dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}

	doicon -s 128 ${FILESDIR}/${PN}.png

	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
