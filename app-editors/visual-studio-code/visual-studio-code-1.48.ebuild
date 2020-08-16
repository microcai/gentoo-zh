# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://update.code.visualstudio.com/${PV}"
SRC_URI="https://vscode.cdn.azure.cn/stable/db40434f562994116e5b21c24015a2e40b2504e6/code-stable-1597305391.tar.gz -> ${P}-amd64.tar.gz"

RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="libsecret"

DEPEND="
	>=media-libs/libpng-1.2.46
	x11-libs/gtk+:3
	x11-libs/cairo
	x11-libs/libXtst
"

RDEPEND="
	${DEPEND}
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	libsecret? ( app-crypt/libsecret[crypt] )
"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64" || S="${WORKDIR}/VSCode-linux-ia32"
}

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/bin/code" "/usr/bin/${PN}"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon ${FILESDIR}/${PN}.png
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/cpuUsage.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/ps.sh"
	fperms +x "/opt/${PN}/resources/app/out/vs/base/node/terminateProcess.sh"
	insinto "/usr/share/licenses/${PN}"
	newins "resources/app/LICENSE.rtf" "LICENSE"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
