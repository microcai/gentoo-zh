# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

PV0="0.9.8.3.r4"
DESCRIPTION="a modern terminal emulator for Linux"
SRC_URI="https://github.com/mytbk/fqterm/archive/${PV0}.tar.gz -> ${PN}-${PV0}.tar.gz"
HOMEPAGE="https://github.com/mytbk/fqterm"
S="${WORKDIR}/${PN}-${PV0}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/openssl
	media-libs/alsa-lib
	dev-qt/qtcore[ssl,qt3support]
	dev-qt/qtgui"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-as-needed.patch"
}
