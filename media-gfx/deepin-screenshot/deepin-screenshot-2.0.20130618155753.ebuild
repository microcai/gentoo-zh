# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime eutils versionator

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://github.com/linuxdeepin/deepin-screenshot.git"
	inherit git-2
	SRC_URI=""
	#KEYWORDS=""
else
	MY_VER="$(get_version_component_range 1-2)+git$(get_version_component_range 3)~8c1ba38453"
	SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${PN}-${MY_VER}
fi

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-screenshot"

LICENSE="LGPL-3"
SLOT="2"
IUSE=""

RDEPEND=">=dev-lang/python-2.7.1:2.7
	>=x11-libs/deepin-ui-1.0.201209291421
	dev-python/pywebkitgtk
	dev-python/libwnck-python
	dev-python/pyxdg
	dev-python/pycurl
	dev-python/python-xlib
	gnome-base/gconf:2
	dev-python/deepin-gsettings
	!media-gfx/deepin-screenshot:3"
DEPEND="dev-python/epydoc"

src_prepare() {
	sh updateTranslate.sh
	sed -i 's|\.\/screenshot\.py|python2\ \.\/screenshot\.py|g' src/${PN}
}

src_install() {
	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/theme ${S}/skin
	fperms 0755 -R /usr/share/${PN}/src/

	dosym /usr/share/${PN}/src/${PN} /usr/bin/${PN}

	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
	
	rm -r ${D}/usr/share/locale/*.po*
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

