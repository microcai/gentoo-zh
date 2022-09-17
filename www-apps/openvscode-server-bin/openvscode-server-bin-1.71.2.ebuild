# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

MY_PN="${PN//-bin/}"
MY_P="${MY_PN}-v${PV}"

DESCRIPTION="VS Code that runs a server on remote and allows access through a web browser"
HOMEPAGE="https://github.com/gitpod-io/openvscode-server"
SRC_URI="
	amd64? ( https://github.com/gitpod-io/openvscode-server/releases/download/${MY_P}/${MY_P}-linux-x64.tar.gz )
	arm? ( https://github.com/gitpod-io/openvscode-server/releases/download/${MY_P}/${MY_P}-linux-armhf.tar.gz )
	arm64? ( https://github.com/gitpod-io/openvscode-server/releases/download/${MY_P}/${MY_P}-linux-arm64.tar.gz )
"
S="${WORKDIR}"

RESTRICT="mirror strip bindist"

LICENSE="
	Apache-2.0
	BSD
	BSD-1
	BSD-2
	BSD-4
	CC-BY-4.0
	ISC
	LGPL-2.1+
	Microsoft-vscode
	MIT
	MPL-2.0
	openssl
	PYTHON
	TextMate-bundle
	Unlicense
	UoI-NCSA
	W3C
"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"

DEPEND="
	app-crypt/libsecret
	dev-libs/libatomic_ops
"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="
	/opt/openvscode-server-bin/node
	/opt/openvscode-server-bin/node_modules/@vscode/ripgrep/bin/rg
	/opt/openvscode-server-bin/node_modules/spdlog/build/Release/spdlog.node
	/opt/openvscode-server-bin/node_modules/keytar/build/Release/obj.target/keytar.node
	/opt/openvscode-server-bin/node_modules/keytar/build/Release/keytar.node
	/opt/openvscode-server-bin/node_modules/native-watchdog/build/Release/watchdog.node
	/opt/openvscode-server-bin/node_modules/@parcel/watcher/build/Release/watcher.node
	/opt/openvscode-server-bin/node_modules/node-pty/build/Release/pty.node
"

src_install() {
	if use amd64; then
		cd "${WORKDIR}/${MY_P}-linux-x64" || die
	elif use arm; then
		cd "${WORKDIR}/${MY_P}-linux-armhf" || die
	elif use arm64; then
		cd "${WORKDIR}/${MY_P}-linux-arm64" || die
	else
		die "openvscode-server only supports amd64, arm and arm64"
	fi

	# Install
	insinto "/opt/${PN}"
	doins -r *
	fperms +x /opt/${PN}/bin/{,remote-cli/}openvscode-server
	fperms +x /opt/${PN}/bin/helpers/browser.sh
	# bundled node
	fperms +x /opt/${PN}/node
	fperms -R +x /opt/${PN}/out/vs/base/node/
	# bundled other binaries
	fperms +x /opt/${PN}/node_modules/@vscode/ripgrep/bin/rg
	fperms +x /opt/${PN}/node_modules/spdlog/build/Release/spdlog.node
	fperms +x /opt/${PN}/node_modules/keytar/build/Release/obj.target/keytar.node
	fperms +x /opt/${PN}/node_modules/keytar/build/Release/keytar.node
	fperms +x /opt/${PN}/node_modules/native-watchdog/build/Release/watchdog.node
	fperms +x /opt/${PN}/node_modules/@parcel/watcher/build/Release/watcher.node
	fperms +x /opt/${PN}/node_modules/node-pty/build/Release/pty.node
	# shellscript from extensions
	fperms +x /opt/${PN}/extensions/ms-vscode.js-debug/src/terminateProcess.sh
	fperms +x /opt/${PN}/extensions/git/dist/{askpass,git-editor}{,-empty}.sh

	dosym "../../opt/${PN}/bin/openvscode-server" "usr/bin/openvscode-server"

	systemd_newuserunit "${FILESDIR}/openvscode-server-user.service" openvscode-server.service
	systemd_newunit "${FILESDIR}/openvscode-server-at.service" openvscode-server@.service
}

pkg_postinst() {
	elog
	elog "When using openvscode-server systemd services run it as a user"
	elog "For example: "
	elog "	'systemctl --user enable --now openvscode-server'"
	elog "	'systemctl enable --now openvscode-server@\$USER'"
	elog "Default access link is http://localhost:3000/?tkn=\$TOKEN"
	elog
	elog "You may want to modify the systemd unit file to match your needs"
	elog "For example: "
	elog "'ExecStart=/usr/bin/openvscode-server --without-connection-token --host 0.0.0.0'"
	elog
	elog "For more details, please refer to https://github.com/gitpod-io/openvscode-server#linux"
	elog
}
