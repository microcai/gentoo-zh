# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_PN="${PN/-bin}"

DESCRIPTION="JLC Order Assistant (binary package)"
HOMEPAGE="https://www.jlc.com/portal/appDownloadsWithConfig.html"
SRC_URI="https://download.jlc.com/pcAssit/${PV}/JLCPcAssit-linux-x64-${PV}.zip -> ${P}.zip"
S="${WORKDIR}/${MY_PN}-linux-x64-${PV}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="splitdebug"

RDEPEND="
	|| (
		>=app-accessibility/at-spi2-core-2.46.0:2
		( app-accessibility/at-spi2-atk dev-libs/atk )
	)
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
	x11-libs/pango
"

DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

QA_PREBUILT="opt/${MY_PN}/chrome-sandbox
	opt/${MY_PN}/chrome_crashpad_handler
	opt/${MY_PN}/${MY_PN}
	opt/${MY_PN}/libEGL.so
	opt/${MY_PN}/libGLESv2.so
	opt/${MY_PN}/libffmpeg.so
	opt/${MY_PN}/libvk_swiftshader.so
	opt/${MY_PN}/libvulkan.so.1
"

src_install() {
	insinto /opt
	doins -r "${MY_PN}"
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
	fperms u+s /opt/"${MY_PN}"/chrome-sandbox

	dosym ../../opt/"${MY_PN}"/"${MY_PN}" /usr/bin/"${MY_PN}"
	newmenu "${S}"/jlc-assistant/jlc-assistant.dkt "${MY_PN}".desktop
}
