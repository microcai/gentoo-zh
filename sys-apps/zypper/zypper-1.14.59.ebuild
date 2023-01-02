# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/openSUSE/zypper.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
else
	SRC_URI="https://github.com/openSUSE/zypper/archive/refs/tags/${PV}.tar.gz -> zypper-${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PV}"
fi

DESCRIPTION="World's most powerful command line package manager"
HOMEPAGE="https://en.opensuse.org/Portal:Zypper"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/libzypp
"
DEPEND="
	app-admin/augeas
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DENABLE_BUILD_TRANS=ON
		-DENABLE_BUILD_TESTS=ON
	)
	cmake_src_configure
}
