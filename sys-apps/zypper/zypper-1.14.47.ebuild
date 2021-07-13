# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

SRC_URI="https://github.com/openSUSE/zypper/archive/refs/tags/${PV}.tar.gz -> zypper-${PV}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="World's most powerful command line package manager"
HOMEPAGE="https://en.opensuse.org/Portal:Zypper"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	app-admin/augeas
	sys-libs/libzypp
	dev-lang/perl
	sys-process/procps
	dev-ruby/asciidoctor
"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_DIR_LIB="$(get_libdir)/${P}"
		-DZYPP_PREFIX="/usr"
	)
	cmake_src_configure
}
