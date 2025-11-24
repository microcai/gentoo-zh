# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Manage all your JetBrains Projects and Tools"
HOMEPAGE="https://www.jetbrains.com/toolbox-app/"
SRC_URI="https://download.jetbrains.com/toolbox/${P}.tar.gz"

S=${WORKDIR}/${P}/bin

LICENSE="JetBrainsToolbox"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror"

QA_PREBUILT="/opt/${PN}/${PN}"

src_install() {
	insinto /opt/"${PN}"

	doins -r .

	fperms +x "/opt/${PN}/${PN}"

	dosym "../../opt/${PN}/${PN}" /usr/bin/jetbrains-toolbox

	domenu "${PN}".desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	chmod -R 777 /opt/"${PN}" # Required for app to behave correctly
}
