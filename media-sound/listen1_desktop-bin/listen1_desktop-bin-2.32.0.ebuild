# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="one for all free music in China"
HOMEPAGE="http://listen1.github.io/listen1
	https://github.com/listen1/listen1_desktop
"
S="${WORKDIR}"
SRC_URI="https://github.com/listen1/listen1_desktop/releases/download/v${PV}/listen1_${PV}_linux_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus[X]
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_PREBUILT="
	opt/Listen1/chrome-sandbox
	opt/Listen1/libEGL.so
	opt/Listen1/libffmpeg.so
	opt/Listen1/libGLESv2.so
	opt/Listen1/libvk_swiftshader.so
	opt/Listen1/libvulkan.so.1
	opt/Listen1/listen1
	opt/Listen1/swiftshader/libEGL.so
	opt/Listen1/swiftshader/libGLESv2.so
"

src_prepare(){
	default
	unpack usr/share/doc/listen1/changelog.gz
	sed -i 's/Audio/AudioVideo/' usr/share/applications/listen1.desktop || die
	rm opt/Listen1/{LICENSE.electron.txt,LICENSES.chromium.html} || die
}

src_install(){
	insinto /
	doins -r opt

	insinto /usr/share
	doins -r usr/share/icons

	dodoc changelog
	domenu usr/share/applications/listen1.desktop

	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
	fperms u+s /opt/Listen1/chrome-sandbox

	dosym ../../opt/Listen1/listen1 /usr/bin/listen1
}
