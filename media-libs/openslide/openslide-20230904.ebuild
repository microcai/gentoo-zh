# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="C library with simple interface to read virtual slides"
HOMEPAGE="http://openslide.org/"
EGIT_COMMIT="239d7bd9f603be159e6558464f311b5b243d12b1"
SRC_URI="https://github.com/openslide/openslide/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~loong"
SLOT="0"
LICENSE="LGPL-2.1"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

DEPEND="
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	media-libs/openjpeg:2
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
