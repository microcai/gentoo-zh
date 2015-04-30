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
	MY_VER="$(get_version_component_range 1-2)+$(get_version_component_range 3)~34d48c47e58"
	SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${PN}-${MY_VER}
fi

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-screenshot"

LICENSE="LGPL-3"
SLOT="3"
IUSE="sharing"

RDEPEND="dev-lang/python
	dev-python/sip
	dev-python/libwnck-python
	x11-libs/xpyb
	dev-python/PyQt5
	sharing? ( net-misc/deepin-social-sharing )
	!media-gfx/deepin-screenshot:2"
DEPEND="dev-python/deepin-gettext-tools"


src_install() {
	
	echo $LINGUAS > ${S}/langs.tmp
	for lang in `cat ${S}/langs.tmp`
	do
	  insinto "/usr/share/locale"
	  doins -r ${S}/locale/mo/${lang}
	done
	
	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/image ${S}/sound
	fperms 0755 -R /usr/share/${PN}/src/
	
	dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}

	insinto "/usr/share/applications"
	doins ${S}/${PN}.desktop
}
pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

