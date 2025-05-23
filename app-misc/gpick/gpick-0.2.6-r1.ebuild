# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="https://github.com/thezbyg/gpick"
SRC_URI="https://github.com/thezbyg/${PN}/archive/${P}.tar.gz"

S="${WORKDIR}/gpick-gpick-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk3 nls"

RDEPEND="
	>=dev-lang/lua-5.2:=
	dev-libs/boost
	dev-libs/expat
	dev-util/ragel
	nls? ( sys-devel/gettext )
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_GTK3=$(usex gtk3 ON OFF)
		-DENABLE_NLS=$(usex nls ON OFF)
	)
	cmake_src_configure
}

src_install() {
	pushd "${BUILD_DIR}"
	exeinto "/usr/$(get_libdir)"
	local so
	for so in *.so
	do
		doexe "${so}"
	done
	popd || die

	cmake_src_install

	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${P}" || die
}
