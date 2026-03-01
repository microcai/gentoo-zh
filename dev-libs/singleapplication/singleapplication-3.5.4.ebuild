# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Replacement of QtSingleApplication support for inter-instance communication"
HOMEPAGE="https://itay-grudev.github.io/SingleApplication/"
SRC_URI="https://github.com/itay-grudev/SingleApplication/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SingleApplication-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-qt/qtbase:6[network]"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

PATCHES=(
	# https://github.com/itay-grudev/SingleApplication/issues/190
	"${FILESDIR}/singleapplication-3.5.2_p20250124-fix-single-instance-with-qt6.patch"
)

src_configure() {
	local mycmakeargs=(
		-DQT_DEFAULT_MAJOR_VERSION=6
		-DQAPPLICATION_CLASS=FreeStandingSingleApplication
		-DSINGLEAPPLICATION_INSTALL=ON
		-DSINGLEAPPLICATION_DOCUMENTATION=$(usex doc)
	)
	cmake_src_configure
}
