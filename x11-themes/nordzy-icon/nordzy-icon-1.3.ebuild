# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Nordzy is a free and open source icon theme for Linux desktops using the Nord color palette from Arctic Ice Studio and based on WhiteSur and Numix Icon Theme"
HOMEPAGE="https://github.com/alvatip/Nordzy-icon"
SRC_URI="https://github.com/alvatip/Nordzy-icon/releases/download/${PV}/Nordzy.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_configure() { :; }

src_compile() { :; }

src_install() {
	insinto /usr/share/icons
	doins -r ./Nordzy
}
