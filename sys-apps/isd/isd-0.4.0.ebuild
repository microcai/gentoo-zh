# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="isd (interactive systemd) — a better way to work with systemd units"
HOMEPAGE="https://github.com/isd-project/isd"
SRC_URI="https://github.com/isd-project/isd/releases/download/v${PV}/isd.x86_64-linux.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="
	sys-apps/systemd
	sys-fs/fuse:0
"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" isd || die
}

src_install() {
	dobin isd
}
