# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="High-performance PDF reader that prioritizes screen space and control"
HOMEPAGE="https://github.com/dheerajshenoy/lektra"
SRC_URI="https://github.com/dheerajshenoy/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl synctex"

DEPEND="
	app-text/mupdf
	dev-qt/qtbase:6[concurrent,gui,widgets]
	curl? ( net-misc/curl )
	synctex? ( app-text/texlive-core )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${P}-system-mupdf.patch
	"${FILESDIR}"/${P}-fix-s_drop_accepted.patch
)

src_configure() {
	local mycmakeargs=(
		-DENABLE_LLM_SUPPORT=$(usex curl ON OFF)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Fix doc path: upstream installs to /usr/share/doc/lektra,
	# but Gentoo requires /usr/share/doc/${PF}
	if [[ -d "${ED}/usr/share/doc/${PN}" && "${PN}" != "${PF}" ]]; then
		mv "${ED}/usr/share/doc/${PN}"/* "${ED}/usr/share/doc/${PF}/" || die
		rmdir "${ED}/usr/share/doc/${PN}" || die
	fi
}
