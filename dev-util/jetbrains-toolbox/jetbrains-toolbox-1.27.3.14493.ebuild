# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Copyright 2019 Rabenda

EAPI=8

inherit xdg desktop

DESCRIPTION="Manage all your JetBrains Projects and Tools"
HOMEPAGE="https://www.jetbrains.com/toolbox/app"
SRC_URI="https://download.jetbrains.com/toolbox/${P}.tar.gz"

LICENSE="JetBrainsToolbox"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror"

DEPEND="sys-fs/fuse:0"

QA_PREBUILT="opt/jetbrains-toolbox/jetbrains-toolbox"

src_compile() {
	./"${PN}" --appimage-extract
}

src_install() {
	keepdir /opt/jetbrains-toolbox
	insinto /opt/jetbrains-toolbox
	doins jetbrains-toolbox

	newicon "${FILESDIR}/${PN}.svg" "${PN}.svg"

	domenu "${FILESDIR}/${PN}.desktop"

	fperms +x /opt/jetbrains-toolbox/jetbrains-toolbox
}
