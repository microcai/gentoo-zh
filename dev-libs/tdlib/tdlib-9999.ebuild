# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
EGIT_REPO_URI="https://github.com/tdlib/td.git"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR="${WORKDIR}/td"

LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc
	dev-libs/openssl
	sys-libs/zlib
	dev-util/gperf
	dev-util/cmake
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${EGIT_CHECKOUT_DIR}"
BUILD_DIR="${S}/build"

src_configure(){
	mkdir ${BUILD_DIR} && cd ${BUILD_DIR} || die
	cmake -GNinja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir) ${S} || die "cmake failed"
}
