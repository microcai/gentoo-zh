# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils fdo-mime

DESCRIPTION="WebStorm is a lightweight yet powerful IDE, perfectly equipped for complex client-side development and server-side development with Node.js."
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download-cf.jetbrains.com/webstorm/WebStorm-${PV}.tar.gz"
IDE_VERSION=141.728

RESTRICT="mirror"
LICENSE=""

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="app-arch/gzip"

RDEPEND="
	virtual/jdk
	net-libs/nodejs
"

S="${WORKDIR}/WebStorm-${IDE_VERSION}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	return
}

src_install() {
	local INSTDIR="/opt/${P}"
	dodir "${INSTDIR}"
	cp -r "${S}/"* "${D}/${INSTDIR}" || die "Install failed!"

	i#rm -rf "{D}/usr/lib/debug"

	make_wrapper webstorm-$PV "${INSTDIR}/bin/webstorm.sh"
	make_desktop_entry "webstorm-$PV" "WebStorm $PV" "${INSTDIR}/bin/webide.png" "Development"
}

pkg_postinst(){
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
