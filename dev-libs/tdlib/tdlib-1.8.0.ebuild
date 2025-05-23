# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="sys-devel/gcc
	dev-libs/openssl
	sys-libs/zlib
	dev-util/gperf
	dev-build/cmake
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/td-${PV}"
