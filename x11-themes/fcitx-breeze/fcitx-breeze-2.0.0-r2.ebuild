# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fcitx5 theme to match KDE's Breeze style."
HOMEPAGE="https://github.com/scratch-er/fcitx5-breeze"

SRC_URI="https://github.com/scratch-er/fcitx5-breeze/archive/refs/tags/v${PV}.tar.gz -> fcitx5-breeze-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-gfx/inkscape"
RDEPEND="
	app-i18n/fcitx:5"

S="${WORKDIR}/fcitx5-breeze-$PV"

src_compile() {
	./build.sh
}

src_install() {
	./install.sh "${D}/usr"
}
