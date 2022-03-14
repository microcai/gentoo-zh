# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker

DESCRIPTION="A simple and elegant markdown editor, available for Linux, macOS and Windows."
HOMEPAGE="https://marktext.app/ https://github.com/marktext/marktext"
SRC_URI="https://github.com/marktext/marktext/releases/download/v${PV}/${PN%-bin}-amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	>=x11-libs/gtk+-3.0:3
	app-crypt/libsecret
	x11-libs/libxkbfile
	dev-libs/nss
	net-print/cups
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install(){
	insinto "/opt"
	doins -r "opt/MarkText"
	fperms 0755 "/opt/MarkText/${PN%-bin}"
	for is in 16 32 48 64 128 256 512; do
		doicon -s ${is} usr/share/icons/hicolor/${is}x${is}/apps/${PN%-bin}.png
	done
	domenu usr/share/applications/marktext.desktop
}
