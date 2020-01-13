# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc
	dev-libs/openssl
	sys-libs/zlib
	dev-util/gperf
	dev-util/cmake
"
RDEPEND="${DEPEND}"
BDEPEND=""
PATCHES=( "${FILESDIR}/${P}-multilib.patch" )

S="${WORKDIR}/td-${PV}"
BUILD_DIR="${S}/build"

src_configure(){
	mkdir ${BUILD_DIR} && cd ${BUILD_DIR} || die
	cmake -GNinja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DLIB=$(get_libdir) ${S} || die "cmake failed"
}
