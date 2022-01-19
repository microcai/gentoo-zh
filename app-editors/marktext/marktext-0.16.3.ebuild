# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A simple and elegant markdown editor, available for Linux, macOS and Windows."
HOMEPAGE="https://marktext.app/ https://github.com/marktext/marktext"
SRC_URI="https://github.com/marktext/marktext/releases/download/v${PV}/${PN}-amd64.deb -> ${PN}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	>=x11-libs/gtk+-3.0:3
	app-crypt/libsecret
	x11-libs/libxkbfile
	dev-libs/nss
	net-print/cups
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack(){
	unpack ${PN}.deb
	tar xfv data.tar.xz || die
}

S="${WORKDIR}"

src_install(){
	insinto "/opt"
	doins -r "opt/Mark Text"
	fperms 0755 "/opt/Mark Text/marktext"
	for is in 16 32 48 64 128 256 512; do
		doicon -s ${is} usr/share/icons/hicolor/${is}x${is}/apps/${PN}.png
	done
	domenu usr/share/applications/marktext.desktop
}

pkg_postinst(){
	xdg_pkg_postinst
}

pkg_postrm(){
	xdg_pkg_postrm
}
