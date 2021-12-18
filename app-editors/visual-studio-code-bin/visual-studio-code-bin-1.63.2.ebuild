# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://update.code.visualstudio.com/${PV}"
SRC_URI="${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret[crypt]
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libxshmfence
	x11-libs/pango
	!app-editors/vscode
"

QA_PRESTRIPPED="*"
QA_FLAGS_IGNORED="*"
QA_PREBUILT="
	opt/${PN}/code
	opt/${PN}/libEGL.so
	opt/${PN}/libffmpeg.so
	opt/${PN}/libGLESv2.so
	opt/${PN}/libvk_swiftshader.so
	opt/${PN}/libvulkan.so
	opt/${PN}/swiftshader/libEGL.so
	opt/${PN}/swiftshader/libGLESv2.so
	opt/${PN}/chrome-sandbox
	opt/${PN}/libvulkan.so.1
	opt/${PN}/resources/*"

S="${WORKDIR}/VSCode-linux-x64"

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "../../opt/${PN}/bin/code" "usr/bin/code"
	domenu "${FILESDIR}/visual-studio-code.desktop"
	domenu "${FILESDIR}/visual-studio-code-url-handler.desktop"
	newicon "resources/app/resources/linux/code.png" "${PN%-bin}.png"
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/resources/app/extensions/git/dist/askpass-empty.sh"
	fperms +x "/opt/${PN}/resources/app/extensions/git/dist/askpass.sh"
	fperms +x "/opt/${PN}/resources/app/extensions/ms-vscode.js-debug/src/terminateProcess.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/cpuUsage.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/ps.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/terminateProcess.sh"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	dodoc "resources/app/LICENSE.rtf"

	insinto "/usr/share/mime/packages"
	doins "${FILESDIR}/visual-studio-code-workspace.xml"
}

pkg_postinst(){
	xdg_pkg_postinst
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
