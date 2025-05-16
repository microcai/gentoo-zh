# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="ZIM file format: an offline storage solution for content coming from the Web"
HOMEPAGE="https://wiki.openzim.org/wiki/OpenZIM"
SRC_URI="https://github.com/openzim/$PN/archive/$PV.tar.gz -> $P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-libs/zlib
	app-arch/lzma
	dev-libs/icu
	app-arch/zstd
	dev-libs/xapian
	sys-fs/e2fsprogs"

DEPEND="virtual/pkgconfig"
