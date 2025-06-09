# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
EGIT_REPO_URI="https://github.com/tdlib/td.git"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR="${WORKDIR}/td"

S="${EGIT_CHECKOUT_DIR}"
LICENSE="Boost-1.0"
SLOT="0"

DEPEND="
	dev-libs/openssl
	dev-util/gperf
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

BUILD_DIR="${S}/build"
