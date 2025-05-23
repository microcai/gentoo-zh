# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Replacement of QtSingleApplication support for inter-instance communication"
HOMEPAGE="https://itay-grudev.github.io/SingleApplication/"
GIT_COMMIT="0ba7b6ce42cfb863cbb1463c274c762e1eb6652b"
SRC_URI="https://github.com/itay-grudev/SingleApplication/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SingleApplication-${GIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-qt/qtbase:6[network]"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DQT_DEFAULT_MAJOR_VERSION=6
		-DQAPPLICATION_CLASS=FreeStandingSingleApplication
		-DSINGLEAPPLICATION_INSTALL=ON
		-DSINGLEAPPLICATION_DOCUMENTATION=$(usex doc)
	)
	cmake_src_configure
}
