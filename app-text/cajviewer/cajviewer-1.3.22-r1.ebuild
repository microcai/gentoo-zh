# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PN="${PN}"

DESCRIPTION="Document Viewer for CAJ, KDH, NH, TEB and PDF format"

HOMEPAGE="http://cajviewer.cnki.net"
SRC_URI="https://download.cnki.net/${PN}_${PV}-1_amd64.deb"
S="${WORKDIR}"

LICENSE="CAJVIEWER-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

RDEPEND="
	net-dns/avahi
	dev-libs/gmp
	net-libs/gnutls
	virtual/krb5
	net-print/cups
	dev-libs/libgcrypt
	net-dns/libidn11
	media-libs/libpng
	dev-libs/libtasn1
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libxkbcommon
	x11-libs/libXrender
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	x11-misc/shared-mime-info
	app-arch/xz-utils
"
DEPEND="${RDEPEND}"

QA_PREBUILT="
	/opt/apps/net.cnki.cajviewer/files/lib/*.so*
	/opt/apps/net.cnki.cajviewer/files/plugins/*/*.so
"
MY_PREFIX="opt/apps/${MY_PN}"

src_install(){
	insinto /
	doins -r .
	fperms 0755 /${MY_PREFIX}/CAJViewer
	fperms 0755 /${MY_PREFIX}/start.sh
}
