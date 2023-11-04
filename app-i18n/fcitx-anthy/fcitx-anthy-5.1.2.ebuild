# Copyright 2013-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Japanese Anthy input methods for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-anthy"

if [[ "${PV}" =~ (^|\.)9999$ ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-anthy"
else
	MY_PN="fcitx5-anthy"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_PN}-${PV}"
	SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_P}.tar.xz"
fi

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="test coverage"
REQUIRED_USE="coverage? ( test )"
RESTRICT="!test? ( test )"

BDEPEND="
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig
"
RDEPEND="
	>=app-i18n/fcitx-5.1.2:5
	app-i18n/anthy
	sys-devel/gettext
	virtual/libintl
"
DEPEND="${RDEPEND}"

DOCS=(AUTHORS)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	)
	cmake_src_configure
}
