# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils pax-utils xdg

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://update.code.visualstudio.com/${PV}"
SRC_URI="${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	>=media-libs/libpng-1.2.46:0
	x11-libs/gtk+:3
	x11-libs/cairo
	x11-libs/libXtst
"

RDEPEND="
	${DEPEND}
	app-crypt/libsecret[crypt]
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
"

QA_PRESTRIPPED="*"
QA_PREBUILT="
	opt/${PN}/code
	opt/${PN}/libEGL.so
	opt/${PN}/libffmpeg.so
	opt/${PN}/libGLESv2.so
	opt/${PN}/libvk_swiftshader.so
	opt/${PN}/libvulkan.so
	opt/${PN}/swiftshader/libEGL.so
	opt/${PN}/swiftshader/libGLESv2.so"

pkg_setup(){
	if use amd64; then
		S="${WORKDIR}/VSCode-linux-x64"
	else
		die "Visual Studio Code only supports amd64"
	fi
}

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/bin/code" "/usr/bin/${PN}"
	domenu "${FILESDIR}/visual-studio-code.desktop"
	doicon "${FILESDIR}/${PN}.png"
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/cpuUsage.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/ps.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/terminateProcess.sh"
	dodoc "resources/app/LICENSE.rtf"
}

pkg_postinst(){
	xdg_pkg_postinst
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
