# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Reqable = Fiddler + Charles + Postman, 让API调试更快 🚀 更简单 👌"
HOMEPAGE="https://reqable.com/"
SRC_URI="https://github.com/reqable/reqable-app/releases/download/${PV}/reqable-app-linux-x86_64.deb -> ${P}.deb"

S="${WORKDIR}"
LICENSE="reqable_license"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-libs/gtk+:3"

RESTRICT="strip mirror"

src_install() {
	insinto /usr/share/reqable
	doins -r "${S}"/usr/share/reqable/*
	fperms 755 /usr/share/reqable/reqable
	domenu "${S}"/usr/share/applications/reqable.desktop
	doicon -s 1024 "${S}"/usr/share/pixmaps/reqable.png
}
