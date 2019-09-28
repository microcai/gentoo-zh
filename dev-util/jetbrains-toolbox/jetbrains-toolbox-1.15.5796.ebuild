# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Copyright 2019 Rabenda

EAPI=6

inherit eutils xdg-utils

DESCRIPTION="Manage all your JetBrains Projects and Tools"
HOMEPAGE="https://www.jetbrains.com/toolbox/app"
SRC_URI="https://download.jetbrains.com/toolbox/${P}.tar.gz"

LICENSE="JetBrainsToolbox"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-fs/fuse:*"

QA_PRESTRIPPED="/opt/jetbrains-toolbox/jetbrains-toolbox"

src_compile() {
        ./"${PN}" --appimage-extract
}

src_install() {
        keepdir /opt/jetbrains-toolbox
        insinto /opt/jetbrains-toolbox
        doins jetbrains-toolbox
        fperms +x /opt/jetbrains-toolbox/jetbrains-toolbox

        newicon squashfs-root/toolbox.svg "${PN}.svg"

        make_wrapper "${PN}" /opt/jetbrains-toolbox/jetbrains-toolbox

        insinto /usr/share/applications
        doins "${FILESDIR}/${PN}.desktop"
}

pkg_postinst() {
        xdg_desktop_database_update
}

pkg_postrm() {
        xdg_desktop_database_update
}

