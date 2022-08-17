# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Cursor theme using the Nord color palette and based on Vimix and cz-Viator"
HOMEPAGE="https://github.com/alvatip/Nordzy-cursors"
SRC_URI="https://github.com/alvatip/Nordzy-cursors/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nord-white"

S="${WORKDIR}/Nordzy-cursors-${PV}"

src_configure() { :; }

src_compile() { :; }

src_install() {
	insinto /usr/share/icons
	doins -r ./Nordzy-cursors

	use nord-white && doins -r ./Nordzy-cursors-white
}
