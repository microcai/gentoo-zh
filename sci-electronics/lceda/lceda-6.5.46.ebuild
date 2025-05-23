# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="LCEDA (binary package)"
HOMEPAGE="https://lceda.cn/"
SRC_URI="https://image.lceda.cn/files/${PN}-linux-x64-${PV}.zip"

S="${WORKDIR}/lceda-linux-x64"
LICENSE="LCEDA-EULA"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libxshmfence
	x11-libs/libXtst
	x11-libs/pango"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

RESTRICT="mirror"

QA_PREBUILT="
	/opt/lceda/swiftshader/libEGL.so
	/opt/lceda/swiftshader/libGLESv2.so
	/opt/lceda/lceda
	/opt/lceda/libEGL.so
	/opt/lceda/libffmpeg.so
	/opt/lceda/libGLESv2.so
"

src_install(){
	insinto /opt/lceda
	doins -r .
	fperms 0755 /opt/lceda/lceda
	newmenu LCEDA.dkt LCEDA.desktop
}
