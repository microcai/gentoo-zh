# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/td-${PV}"
LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="
	dev-libs/openssl
	dev-util/gperf
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
